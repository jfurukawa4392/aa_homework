require 'hand'

describe Hand do
  let(:card) {double("card")}
  let(:deck) {double("deck", deal: card)}
  subject(:hand) {Hand.new(deck)}

  describe "#initialize" do
    it "generates 5 cards in an array" do
      expect(hand.stack.size).to eq(5)
      expect(hand.stack).to be_and_instance_of(Array)
      expect(hand.stack.first).to be_an_instance_of(card)
    end
  end
end
