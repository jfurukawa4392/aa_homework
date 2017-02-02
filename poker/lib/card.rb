require 'byebug'
class Card

  attr_reader :value, :suit

    VALUES = %w{2 3 4 5 6 7 8 9 10 J Q K A}
    SUITS = ['D','C','S','H']

  def initialize(type)
    valid = type.is_a?(Array) &&
            VALUES.include?(type[0]) && SUITS.include?(type[1])
    raise ArgumentError unless valid
    @value = type[0]
    @suit = type[1]
  end
end
