require_relative 'class/deck'
require_relative 'class/player'
require_relative 'class/dealer'
require_relative 'class/table'
require_relative 'class/account'


player_credit = 0
dealer = []
player = []
in_play = true


# Set players credit
while true

  puts 'How much credit do you want to load?'
  player_credit = gets.to_f

  if player_credit.is_a?(Numeric) && player_credit > 0
    break
  end
end

puts 'What is this players name?'
player_name = gets.to_s

# Initialize players including dealer
if player_name.is_a? String
  player = Player.new(player_name, Account.new(player_credit))
  dealer = Dealer.new(Account.new(100000))
end


while in_play
  # Add funding
  if player.account.balance == 0
    puts "#{player.name} you need to add more funds, How much?"
    add_funds = gets.to_f

    if add_funds.is_a?( Numeric ) && add_funds > 0
      player.account.add(add_funds)
    end
  end

  # request bet value
  puts "#{player.name.chomp} how much would you like to bet?"
  the_bet = gets.to_f

  # Add bets to account
  if the_bet <= player.account.balance
    player.account.make_bet(the_bet)
    dealer.account.make_bet(the_bet)
  else
    puts "Reduce bet as #{the_bet} exceeds balance total of #{player.account.balance}"
    next
  end

  # Initialize a new deck
  deck = Deck.new(6)
  initial_deal = deck.deal(2)
  player.hand = initial_deal.shift
  dealer.hand = initial_deal.shift

  # Initialize and Display Table
  table = Table.new(player, dealer)
  table.display_game

  # Player Turn
  while true
    puts "#{player.name.chomp} Hit (H) or Stick (S)"
    hit_stick = gets.chomp.to_s.downcase


    if hit_stick == 'h'
      player.add_card(deck.deal(1).shift)
      table.display_game
    elsif hit_stick == 's'
      if player.score < 17
        puts "Need to have score greater than 17 to stick"
        next
      end

      table.display_game
      break
    end

    if player.bust
      break
    end

    if player.blackjack
      break
    end

    if player.score == 21
      break
    end

  end

  # make all dealers card visible
  dealer.players_turn = false

  # add the dealers cards
  while true

    if dealer.score < 17
      dealer.add_card(deck.deal(1).shift)
      table.display_game
    elsif dealer.score < player.score && !player.bust
      dealer.add_card(deck.deal(1).shift)
      table.display_game
    else
      break
    end
  end

  # Pay the winner
  if dealer.bust && player.bust
    player.account.tie
    dealer.account.tie
  elsif dealer.bust
    player.account.add_winning
  elsif player.bust
    dealer.account.add_winning
  elsif player.score > dealer.score
    player.account.add_winning
  elsif player.score < dealer.score
    dealer.account.add_winning
  elsif player.score == dealer.score
    dealer.account.tie
    player.account.tie
  end


  table.display_game
  table.display_result

  # Check the player wants to play again
  while true
    puts '=' * 40
    puts "Do you want to player again? Y or N"
    player_again = gets.chomp.to_s.downcase

    if player_again == 'y'
      dealer.players_turn = true
      break
    elsif player_again == 'n'
      in_play = false
      break
    end
  end

end