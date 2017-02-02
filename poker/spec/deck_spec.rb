require 'deck'

describe Deck do

  describe "#initialize" do
    subject(:deck) {Deck.new}
    it "should generate a 52 cards" do
      expect(deck.length).to eq(52)
    end

    it "should have four suits" do
      suits = []
      deck.stack.each do |card|
        suits << card.suit unless suits.include?(card.suit)
      end
      expect(suits).to eq(['D','C','S','H'])
    end

    it "should have 13 values for each suit" do
      values = []
      deck.stack.each do |card|
        values << card.value unless values.include?(card.value)
      end
      expect(values).to eq(['2','3','4','5','6','7','8','9','10','J','Q','K','A'])
    end
  end

  describe "#shuffle" do
    subject(:deck) {Deck.new}
    it "randomizes the order of the cards" do
      shuffled = deck.shuffle
      expect(shuffled.stack).not_to eq(Deck.new.stack)
      expect(shuffled).to eql(deck)
    end
  end

  describe "#deal" do
    subject(:deck){Deck.new}
    it "decreases the stack variable by one" do
      expect(deck.stack.length).to eq(52)
      deck.deal(3)
      expect(deck.stack.length).to eq(49)
    end

    it "returns an array of cards" do
      expect(deck.deal(1)).to be_an_instance_of(Array)
    end

    it "raises error if not enough cards" do
      expect{deck.deal(53)}.to raise_error("Not enough cards!")
    end
  end
end
