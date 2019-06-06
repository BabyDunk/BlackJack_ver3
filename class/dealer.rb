class Dealer < Eval

  attr_accessor :name, :players_turn

  def initialize(account, hand=[], players_turn=true)
    super(hand, account)
    @players_turn = players_turn
    @name = "Dealer"
  end

end
