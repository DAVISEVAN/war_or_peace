# spec/card_spec.rb

require 'rspec'
require './lib/card'

RSpec.describe Card do
  describe "#suit" do
    it "returns the suit of the card" do
      card = Card.new(:heart, 'Jack', 11)
      expect(card.suit).to eq(:heart)
    end
  end

  describe "#value" do
    it "returns the value of the card" do
      card = Card.new(:heart, 'Jack', 11)
      expect(card.value).to eq('Jack')
    end
  end

  describe "#rank" do
    it "returns the rank of the card" do
      card = Card.new(:heart, 'Jack', 11)
      expect(card.rank).to eq(11)
    end
  end
end
