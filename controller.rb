class Controller
  include Interface

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
    @user = User.new(ask_name)
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

  def player_clear_cards
    @user.cards = []
    @dealer.cards = []
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
    case select_choice
    when 'card'
      choice_card
    when 'open'
      open_cards
    when 'skip'
      skip_step(@user)
      @dealer.step(@deck)
      step
    else
      step
    end
  end

  def choice_card
    if card_limit?(@user)
      card_limit
    else
      @user.take_card(@deck)
      show_info
      if score_limit?(@user)
        open_cards
      else
        @dealer.step(@deck)
        step
      end
    end
  end

  def card_limit?(player)
    player.cards.size > 2
  end

  def score_limit?(player)
    player.score > 21
  end

  def open_cards
    money_to_winner
    end_result_info
    one_more_game
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
