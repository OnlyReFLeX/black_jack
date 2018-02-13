class Bank
  attr_reader :money
  def initialize
    @money = 0
  end

  def debet(amount)
    @money += amount
  end

  def credit(amount)
    @money -= amount
  end
end
