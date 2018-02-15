module Interface
  def game_over
    puts "На счету у вас #{@user.bank}$, а у диллера #{@dealer.bank}$
          вы не можете играть дальше"
    exit
  end

  def show_info
    puts '....----==Информация==----....'
    puts "#{@user.score} ваши очки"
    puts "Ставка #{@bank.money}$"
    puts "#{@user.name} #{@user.bank}$ | #{@dealer.name} #{@dealer.bank}$"
    puts "Твои карты #{@user.all_cards}"
    puts "Карты у диллера #{@dealer.hide_cards}"
  end

  def end_result_info
    puts '....----==Результат==----....'
    puts "Победитель: #{winner_name}"
    puts "Карты диллера #{@dealer.all_cards} | очки #{@dealer.score}"
    puts "Твои карты #{@user.all_cards} | очки #{@user.score}"
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
    winner ? winner.name : 'ничья'
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
