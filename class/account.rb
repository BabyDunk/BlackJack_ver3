class Account
  attr_accessor :bet, :balance

  def initialize(balance,bet=0)
    @bet = bet
    @balance = balance
  end

  def make_bet(value)

    if value <= @balance
      @balance -= value.to_f
      @bet = value.to_f
    end

  end

  def add_winning
    @balance += (@bet*2)
    @bet = 0
    @balance
  end

  def tie
    @balance += @bet
    @bet = 0
    @balance
  end

  def add(value)
    @balance += value.to_f
    @balance
  end

  def balance
    @balance
  end

end
