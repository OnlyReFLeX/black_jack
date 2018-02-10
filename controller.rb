class Controller
  def initialize
    @dealer = Dealer.new
    @cards = Card.new
  end
  #Придумать метод #start
  def start
    print 'Как вас называть: '
    name = gets.chomp
    @player = Player.new(name)
  end

  #Управление ходами
  #Дисплей игры
  #Подсчет результатов
end
