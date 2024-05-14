# spec/player_spec.rb

require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'

RSpec.describe Player do
  let(:card1) { Card.new(:diamond, 'Queen', 12) }
  let(:card2) { Card.new(:spade, '3', 3) }
  let(:card3) { Card.new(:heart, 'Ace', 14) }
  let(:deck) { Deck.new([card1, card2, card3]) }
  let(:player) { Player.new('Clarisa', deck) }

  describe "#initialize" do
    it "creates a new player with a name and a deck" do
      expect(player.name).to eq('Clarisa')
      expect(player.deck).to eq(deck)
    end
  end

  describe "#has_lost?" do
    context "when the player still has cards" do
      it "returns false" do
        expect(player.has_lost?).to be false
      end
    end

    context "when the player has no cards left" do
      it "returns true" do
        3.times { player.deck.remove_card }
        expect(player.has_lost?).to be true
      end
    end
  end
end
