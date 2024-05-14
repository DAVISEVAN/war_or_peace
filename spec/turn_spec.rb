# spec/turn_spec.rb

require 'rspec'
require './lib/turn'
require './lib/player'
require './lib/deck'
require './lib/card'

RSpec.describe Turn do
  let(:card1) { Card.new(:heart, 'Jack', 11) }
  let(:card2) { Card.new(:diamond, 'Jack', 11) }
  let(:card3) { Card.new(:club, 'Jack', 11) }
  let(:card4) { Card.new(:heart, '2', 2) }
  let(:card5) { Card.new(:spade, '3', 3) }
  let(:card6) { Card.new(:diamond, 'Queen', 12) }
  let(:player1) { Player.new("Player 1", Deck.new([card1, card2, card3])) }
  let(:player2) { Player.new("Player 2", Deck.new([card4, card5, card6])) }

  describe "#type" do
    context "when it's a basic turn" do
      let(:turn) { Turn.new(player1, player2) }
      
      it "returns :basic" do
        expect(turn.type).to eq(:basic)
      end
    end

    context "when it's a war turn" do
      let(:turn) do
        player1.deck.remove_card
        player2.deck.remove_card
        Turn.new(player1, player2)
      end

      it "returns :war" do
        expect(turn.type).to eq(:war)
      end
    end

    context "when it's a mutually assured destruction turn" do
      let(:turn) do
        player1.deck.remove_card
        player2.deck.remove_card
        player1.deck.remove_card
        player2.deck.remove_card
        Turn.new(player1, player2)
      end

      it "returns :mutually_assured_destruction" do
        expect(turn.type).to eq(:mutually_assured_destruction)
      end
    end
  end

  describe "#winner" do
    context "when it's a basic turn" do
      let(:turn) { Turn.new(player1, player2) }

      it "returns the winner of the basic turn" do
        expect(turn.winner).to eq(player1)
      end
    end

    context "when it's a war turn" do
      let(:turn) do
        player1.deck.remove_card
        player2.deck.remove_card
        Turn.new(player1, player2)
      end

      it "returns the winner of the war turn" do
        expect(turn.winner).to eq(player2)
      end
    end

    context "when it's a mutually assured destruction turn" do
      let(:turn) do
        player1.deck.remove_card
        player2.deck.remove_card
        player1.deck.remove_card
        player2.deck.remove_card
        Turn.new(player1, player2)
      end

      it "returns 'No Winner'" do
        expect(turn.winner).to eq("No Winner")
      end
    end
  end

  describe "#pile_cards" do
    let(:turn) { Turn.new(player1, player2) }

    it "piles the cards according to the turn type" do
      turn.pile_cards
      expect(turn.spoils_of_war.length).to eq(2)
    end
  end

  describe "#award_spoils" do
    let(:turn) { Turn.new(player1, player2) }

    before do
      turn.spoils_of_war << card1
      turn.spoils_of_war << card2
      turn.spoils_of_war << card3
    end

    it "awards the spoils to the winner" do
      winner = turn.winner
      turn.award_spoils(winner)
      expect(winner.deck.cards.length).to eq(5)
    end
  end
end