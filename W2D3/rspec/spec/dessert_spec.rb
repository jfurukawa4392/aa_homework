require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Jesse") }
  subject(:dessert) { Dessert.new("pie", 10, :chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("pie")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty()
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("pie", "hi", :chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(dessert.add_ingredient("pumpkin")).to include("pumpkin")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do

      ["pumpkin", "milk", "eggs"].each { |ingr| dessert.add_ingredient(ingr) }
      expect(dessert.ingredients).to match_array(["pumpkin", "milk", "eggs"])
      dessert.mix!

      expect(dessert.ingredients).not_to eq(["pumpkin", "milk", "eggs"])
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(5)
      expect(dessert.quantity).to eq(5)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(1000) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Jesse")
      expect(dessert.serve).to eq("Jesse has made 10 desserts!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
