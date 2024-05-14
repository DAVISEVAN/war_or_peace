# bin/war_or_peace_runner.rb

require '../lib/card'
require '../lib/deck'
require '../lib/player'
require '../lib/turn'

# Method to check if a player has lost
def game_over?(player1, player2)
  player1.has_lost? || player2.has_lost?
end

# Method to announce the winner of the game
def announce_winner(player1, player2)
  if player1.has_lost?
    puts "#{player2.name} won the game!"
  elsif player2.has_lost?
    puts "#{player1.name} won the game!"
  end
end

# Create an array to hold all the cards
all_cards = []

# Generate cards for each suit and rank
[:hearts, :diamonds, :clubs, :spades].each do |suit|
  (2..14).each do |rank|
    value = case rank
            when 11 then 'Jack'
            when 12 then 'Queen'
            when 13 then 'King'
            when 14 then 'Ace'
            else rank.to_s
            end
    all_cards << Card.new(suit, value, rank)
  end
end

# Shuffle the cards to create randomness
all_cards.shuffle!

# Split the deck in half to create two player decks
half_size = all_cards.size / 2
deck1 = Deck.new(all_cards[0...half_size])
deck2 = Deck.new(all_cards[half_size..-1])

# Create players
player1 = Player.new("Megan", deck1)
player2 = Player.new("Aurora", deck2)

# Main game loop
until game_over?(player1, player2)
  # Create a turn
  turn = Turn.new(player1, player2)

  # Print turn information
  puts "Turn Type: #{turn.type}"
  puts "Winner: #{turn.winner}"
  puts "Spoils of War: #{turn.spoils_of_war}"

  # Award spoils to the winner
  turn.award_spoils(turn.winner)
end

# Announce the winner of the game
announce_winner(player1, player2)
