class Deck
  SUITS = %w[♦ ♥ ♠ ♣].freeze
  RANKS = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze
  VALUES = [
    [11, 1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [10], [10], [10]
  ].freeze

  attr_reader :cards

  def initialize
    @cards = generate_cards
  end

  private

  def generate_cards
    cards = []
    SUITS.each do |suit|
      RANKS.each_with_index do |rank, i|
        cards << Card.new(suit, rank, VALUES[i])
      end
    end
    cards.shuffle
  end
end
