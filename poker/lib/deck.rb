require 'card'
require 'byebug'

class Deck

  attr_reader :stack, :length

  VALUES = %w{2 3 4 5 6 7 8 9 10 J Q K A}
  SUITS = ['D','C','S','H']

  def initialize
    @stack = build_deck
    @length = @stack.length
  end

  def build_deck
    # byebug
    cards = []
    VALUES.each do |val|
      SUITS.each do |suit|
        cards << Card.new([val, suit])
      end
    end

    cards
  end

  def shuffle
    @stack.shuffle!
    self
  end

  def deal(num_cards = 1)
    raise "Not enough cards!" if num_cards > length
    result = []
    num_cards.times do |x|
      result << @stack.pop
    end

    result
  end
end
