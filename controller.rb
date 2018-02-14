class Controller
  def initialize
    @dealer = Dealer.new
    @bank = Bank.new
  end

  def start
    introduce
    new_game
  end

  private

  def introduce
    print 'Как вас называть: '
    name = gets.chomp
    @user = User.new(name)
  end

  def new_game
    game_over if money_empty?
    new_deck
    player_clear_cards
    round
  end

  def money_empty?
    @user.bank <= 0 || @dealer.bank <= 0
  end

  def game_over
    puts "На счету у вас #{@user.bank}$, а у диллера #{@dealer.bank}$
          вы не можете играть дальше"
    exit
  end

  def player_clear_cards
    @user.cards = []
    @dealer.cards = []
  end

  def show_info
    puts '....----==Информация==----....'
    puts "#{@user.score} ваши очки"
    puts "Ставка #{@bank.money}$"
    puts "#{@user.name} #{@user.bank}$ | #{@dealer.name} #{@dealer.bank}$"
    puts "Твои карты #{@user.all_cards}"
    puts "Карты у диллера #{@dealer.hide_cards}"
  end

  def round
    @user.make_bet(@bank)
    @dealer.make_bet(@bank)
    2.times do
      @user.take_card(@deck)
      @dealer.take_card(@deck)
    end
    show_info
    step
    open_cards
  end

  def step
    print 'Взять карту "card" / открыть карты "open"/ пропустить "skip"'
    choice = gets.chomp
    case choice
    when 'card'
      choice_card
    when 'open'
      open_cards
    when 'skip'
      puts 'Вы пропустили ход'
      @dealer.step(@deck)
      step
    else
      step
    end
  end

  def choice_card
    if @user.cards.size > 2
      puts 'Вы не можете больше взять карту'
      step
    else
      @user.take_card(@deck)
      show_info
      if @user.score > 21
        open_cards
      else
        @dealer.step(@deck)
        step
      end
    end
  end

  def open_cards
    money_to_winner
    puts '....----==Результат==----....'
    puts "Победитель: #{winner_name}"
    puts "Карты диллера #{@dealer.all_cards} | очки #{@dealer.score}"
    puts "Твои карты #{@user.all_cards} | очки #{@user.score}"
    one_more_game
  end

  def one_more_game
    puts 'Хотите еще раз сыграть ?  ( y / n )'
    case gets.chomp
    when 'y'
      new_game
    when 'n'
      exit
    end
  end

  def money_to_winner
    if winner
      winner.add_money(@bank.money)
    else
      amount = @bank.money / 2
      @user.add_money(amount)
      @dealer.add_money(amount)
    end
    @bank.credit(@bank.money)
  end

  def winner_name
    winner ? winner.name : 'ничья'
  end

  def winner
    if @user.score > 21
      @dealer
    elsif @dealer.score > 21
      @user
    elsif @dealer.score != @user.score
      [@user, @dealer].max_by(&:score)
    end
  end

  def new_deck
    @deck = Deck.new
  end
end
