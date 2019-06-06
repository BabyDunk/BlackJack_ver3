class Table

  attr_accessor :player, :dealer

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  def display_game
    @player.check_hand
    @dealer.check_hand

    if @player.bust
      puts '*'*33
      puts "*\t#{@player.name.chomp} you are bust\t*"
      puts "*"*33
    end

    if @player.blackjack
      puts "*"*33
      puts "*\t#{@player.name.chomp} You have Blackjack\t*"
      puts "*"*33
    end

    puts "="*40
    puts "Dealers Hand"
    display_hand(@dealer.hand,@dealer.players_turn)
    puts "="*40
    puts "#{@player.name.chomp}'s Hand\tBalance:#{@player.account.balance}\tScore: #{@player.score}"
    display_hand(@player.hand)
    puts "="*40

  end

  def display_hand(hand, players_turn=false)
    hand.each_with_index do |card, index|
      if index == 0 && players_turn
        puts "Card Face Down"
      else
        puts "#{card[:card]} of #{card[:suit]}"
      end
    end
  end

  def display_result
    if @player.bust && @dealer.bust
      puts "*"*40
      puts "Dealers Score:#{@dealer.score}\t#{@player.name} Score: #{@player.score}"
      puts "You're Both Bust"
      puts "You tied, Your balance is #{player.account.balance}"
      puts "*"*40
    elsif @player.bust
      puts "*"*40
      puts "Dealers Score:#{@dealer.score}\t#{@player.name} Score: #{@player.score}"
      puts "You Bust"
      puts "Dealer Won, Your new balance is #{player.account.balance}"
      puts "*"*40
    elsif @dealer.bust
      puts "*"*40
      puts "Dealer Bust"
      puts "Dealers Score:#{@dealer.score}\t#{@player.name} Score: #{@player.score}"
      puts "You Won, Your new balance is #{player.account.balance}"
      puts "*"*40
     elsif @dealer.score < @player.score
      puts "*"*40
      puts "Dealers Score:#{@dealer.score}\t#{@player.name} Score: #{@player.score}"
      puts "You Won, Your new balance is #{player.account.balance}"
      puts "*"*40
     elsif  @dealer.score > @player.score
      puts "*"*40
      puts "Dealers Score:#{@dealer.score}\t#{@player.name} Score: #{@player.score}"
      puts "Dealer Won, Your new balance is #{player.account.balance}"
      puts "*"*40
    else
      puts "*"*40
      puts "Dealers Score:#{@dealer.score}\t#{@player.name} Score: #{@player.score}"
      puts "You tied, Your balance is #{player.account.balance}"
      puts "*"*40
    end
  end
end
