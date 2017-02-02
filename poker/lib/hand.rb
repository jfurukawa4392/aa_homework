require 'card'

class Hand

  attr_reader :stack

  def initialize(deck)
    @stack = deck.deal(5)
  end
end
