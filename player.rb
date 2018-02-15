class Player
  attr_reader :name
  attr_accessor :bank, :cards
  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
  end

  def make_bet(bank)
    @bank -= 10
    bank.debet(10)
  end

  def add_money(money)
    @bank += money
  end

  def take_card(deck)
    card = deck.cards.sample
    @cards << card
    deck.cards.delete(card)
  end

  def score
    @score = 0
    @cards.each do |card|
      @score += if @score + card.value.max > 21
                  card.value.min
                else
                  card.value.max
                end
    end
    @score
  end

  def all_cards
    all_cards = ''
    @cards.each { |card| all_cards = "#{all_cards} #{card.face}" }
    all_cards
  end
end
