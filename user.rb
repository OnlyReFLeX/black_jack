class User < Player
  def take_card(cards)
    card = super(cards)
    puts "#{name} взял карту #{card.face}"
  end
end
