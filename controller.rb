class Controller
  def initialize
    @dealer = Dealer.new('Dealer')
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
    @deck = Card.new_deck
    @user.cards = []
    @dealer.cards = []
    round
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
    end_game
  end

  def step
    print 'Взять карту "card" / открыть карты "open"/ пропустить "skip"'
    choice = gets.chomp
    case choice
    when 'card'
      if @user.cards.size > 2
        puts 'Вы не можете больше взять карту'
        step
      else
        @user.take_card(@deck)
        if @user.score > 21
          end_game
        else
          @dealer.step(@deck)
          step
        end
      end
    when 'open'
      end_game
    when 'skip'
      puts 'Вы пропустили ход'
      @dealer.step(@deck)
      step
    else
      step
    end
  end

  def end_game
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
end
