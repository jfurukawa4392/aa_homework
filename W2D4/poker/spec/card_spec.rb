require 'card'

describe Card do
  describe "#initialize" do
    subject(:card) {Card.new(["A","C"])}

    it "is initialized with a value and a suit" do
      expect(card.value).to eq("A")
      expect(card.suit).to eq("C")
    end

    it "raises an error if card is invalid" do
      expect{ Card.new(5) }.to raise_error(ArgumentError)
      expect{ Card.new("S") }.to raise_error(ArgumentError)
    end

  end
end
