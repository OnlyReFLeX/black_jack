class Card
  attr_reader :suit, :rank, :value

  SUITS = %w[♦ ♥ ♠ ♣].freeze
  RANKS = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze
  VALUES = [
    [11, 1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [10], [10], [10]
  ].freeze
  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
  end

  def self.new_deck
    deck = []
    SUITS.each do |suit|
      RANKS.each_with_index do |rank, i|
        deck << Card.new(suit, rank, VALUES[i])
      end
    end
    deck
  end

  def face
    rank + suit
  end
end
