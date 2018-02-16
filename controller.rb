class Controller
  attr_reader :dealer, :bank, :user, :deck
  def initialize(user)
    @user = user
    @dealer = Dealer.new
    @bank = Bank.new
  end

  def money_empty?
    @user.bank <= 0 || @dealer.bank <= 0
  end

  def player_clear_cards
    @user.cards = []
    @dealer.cards = []
  end

  def card_limit?(player)
    player.cards.size > 2
  end

  def score_limit?(player)
    player.score > 21
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

  def take_two_card_make_bet
    @user.make_bet(@bank)
    @dealer.make_bet(@bank)
    2.times do
      @user.take_card(@deck)
      @dealer.take_card(@deck)
    end
  end

  def winner
    if score_limit?(@user)
      @dealer
    elsif score_limit?(@dealer)
      @user
    elsif @dealer.score != @user.score
      [@user, @dealer].max_by(&:score)
    end
  end

  def new_deck
    @deck = Deck.new
  end
end
