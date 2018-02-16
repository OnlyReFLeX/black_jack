class Interface
  def initialize
    @controller = Controller.new(introduce)
  end

  def start
    new_game
  end

  private

  def introduce
    @user = User.new(ask_name)
  end

  def new_game
    game_over if @controller.money_empty?
    @controller.new_deck
    @controller.player_clear_cards
    round
  end

  def open_cards
    @controller.money_to_winner
    end_result_info
    one_more_game
  end

  def round
    @controller.take_two_card_make_bet
    show_info
    step
    open_cards
  end

  def step
    case select_choice
    when 'card'
      choice_card
    when 'open'
      open_cards
    when 'skip'
      skip_step(@controller.user)
      @controller.dealer.step(@controller.deck)
      step
    else
      step
    end
  end

  def choice_card
    if @controller.card_limit?(@controller.user)
      card_limit
    else
      @user.take_card(@controller.deck)
      show_info
      if @controller.score_limit?(@controller.user)
        open_cards
      else
        @controller.dealer.step(@controller.deck)
        step
      end
    end
  end

  def game_over
    puts "На счету у вас #{@user.bank}$, а у диллера #{@dealer.bank}$
          вы не можете играть дальше"
    exit
  end

  def show_info
    puts '....----==Информация==----....'
    puts "#{@controller.user.score} ваши очки"
    puts "Ставка #{@controller.bank.money}$"
    puts "#{@controller.user.name} #{@controller.user.bank}$ | #{@controller.dealer.name} #{@controller.dealer.bank}$"
    puts "Твои карты #{@controller.user.all_cards}"
    puts "Карты у диллера #{@controller.dealer.hide_cards}"
  end

  def end_result_info
    puts '....----==Результат==----....'
    puts "Победитель: #{winner_name}"
    puts "Карты диллера #{@controller.dealer.all_cards} | очки #{@controller.dealer.score}"
    puts "Твои карты #{@controller.user.all_cards} | очки #{@controller.user.score}"
  end

  def one_more_game
    puts 'Хотите еще раз сыграть ?  ( y / n )'
    case gets.chomp
    when 'y'
      new_game
    when 'n'
      exit
    else
      one_more_game
    end
  end

  def skip_step(player)
    puts "#{player.name} пропустил ход"
  end

  def winner_name
    @controller.winner ? @controller.winner.name : 'ничья'
  end

  def select_choice
    print 'Взять карту "card" / открыть карты "open"/ пропустить "skip": '
    gets.chomp
  end

  def ask_name
    print 'Как вас зовут: '
    gets.chomp
  end

  def card_limit
    puts 'Вы не можете больше взять карту'
    step
  end
end
