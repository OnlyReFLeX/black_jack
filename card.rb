class Card
  def initialize
    # Что-то с ним сделать, создавать карты на автоматическом уровне
    # а что если карты это не прость строки а объекты ? Ведь так и есть
    # (Подумать над исправлением)
    @cards = [
      '2♦', '3♦', '4♦', '5♦', '6♦', '7♦', '8♦', '9♦', '10♦', 'K♦', 'Q♦', 'J♦',
      'A♦', '2♥', '3♥', '4♥', '5♥', '6♥', '7♥', '8♥', '9♥', '10♥', 'K♥', 'Q♥',
      'J♥', 'A♥', '2♣', '3♣', '4♣', '5♣', '6♣', '7♣', '8♣', '9♣', '10♣', 'K♣',
      'Q♣', 'J♣', 'A♣', '2♠', '3♠', '4♠', '5♠', '6♠', '7♠', '8♠', '9♠', '10♠',
      'K♠', 'Q♠', 'J♠', 'A♠'
    ].shuffle
  end
end
