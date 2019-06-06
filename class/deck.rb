class Deck
  attr_accessor :deck, :deck_num

  def initialize(deck_num = 1)
    @deck_num = deck_num
    @deck = shuffle_deck
  end

  def build_deck
    # Base units
    values = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    suits = %w[Heart Diamond Spade Club]
    decked = []

    @deck_num.times do
      suits.each do |suit|
        values.each_with_index do |val, index|

          if %w[J Q K].include? val
            decked << {:card => val, :suit => suit, :value => 10}
          elsif val == 'A'
            decked << {:card => val, :suit => suit, :value => 11}
          else
            decked << {:card => val, :suit => suit, :value => (index.to_i + 2)}
          end

        end
      end
    end
    decked
  end

  def shuffle_deck
    the_deck = build_deck
    the_deck.each_with_index do |card, index|
      rand_card = rand((the_deck.length - 1))
      holder = the_deck[index]
      the_deck[index] = the_deck[rand_card]
      the_deck[rand_card] = holder
    end
    the_deck
  end

  def deal(player_count)
    all_hands = []

    if @deck.length == (52*@deck_num)
      player_count.times do

        start_hand = []
        start_hand << @deck.shift
        start_hand << @deck.shift

        all_hands << start_hand

      end
    else

      all_hands << @deck.shift
    end

    all_hands
  end

end
