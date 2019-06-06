class Eval

  attr_accessor :hand, :account, :score

  def initialize(hand, bank)
    @hand = hand
    @account = bank
    @score = 0
  end

  def check_hand
    is_ace = 0
    @score = 0

    # Calculate card values
    @hand.each do |card|
      if card[:value] >= 11
        is_ace += 1
        @score += card[:value]
      else
        @score += card[:value]
      end
    end

    # recalculate if bust but has Ace in hand
    if @score > 21 and is_ace > 0
      is_ace.times do
        @score -= 10

        if @score <= 21
          break
        end
      end
    end

    @score
  end

  def blackjack
    check_hand == 21 && @hand.length == 2
  end

  def bust
    check_hand > 21
  end

  def add_card(card)

    @hand << card
  end

  def player_hand
    @hand
  end

end
