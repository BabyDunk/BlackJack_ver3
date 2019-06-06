require_relative 'eval'

class Player < Eval
  attr_accessor :name

  def initialize(name, bank, hand=[])
    super(hand, bank)

    @name = name.chomp.to_s.capitalize
  end

end