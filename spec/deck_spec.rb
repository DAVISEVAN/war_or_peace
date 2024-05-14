# spec/deck_spec.rb

require 'rspec'
require './lib/card'
require './lib/deck'

RSpec.describe Deck do
    let(:card1) { Card.new(:diamond, 'Queen', 12) }
    let(:card2) { Card.new(:spade, '3', 3) }
    let(:card3) { Card.new(:heart, 'Ace', 14) }
    let(:cards) { [card1, card2, card3] }
    let(:deck) { Deck.new(cards) }
  
    describe "#initialize" do
      it "creates a new deck with an array of cards" do
        expect(deck.cards).to eq(cards)
      end
    end
  
    describe "#rank_of_card_at" do
      it "returns the rank of the card at a given index" do
        expect(deck.rank_of_card_at(0)).to eq(12)
        expect(deck.rank_of_card_at(2)).to eq(14)
      end
    end
  
    describe "#high_ranking_cards" do
      it "returns an array of high ranking cards" do
        expect(deck.high_ranking_cards).to eq([card1, card3])
      end
    end
  
    describe "#percent_high_ranking" do
      it "returns the percentage of high ranking cards in the deck" do
        expect(deck.percent_high_ranking).to eq(66.67)
      end
    end
  
    describe "#remove_card" do
      context "when removing a card" do
        it "removes the top card from the deck" do
          removed_card = deck.remove_card
          expect(deck.cards).to_not include(card1)
          expect(removed_card).to eq(card1)
        end
  
        it "updates the high ranking cards and percentage" do
          deck.remove_card
          expect(deck.high_ranking_cards).to eq([card3])
          expect(deck.percent_high_ranking).to eq(50.0)
        end
      end
    end
  
    describe "#add_card" do
      let(:card4) { Card.new(:club, '5', 5) }
  
      context "when adding a card" do
        it "adds a card to the bottom of the deck" do
          deck.add_card(card4)
          expect(deck.cards.last).to eq(card4)
        end
      end
    end
  end
  