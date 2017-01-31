class Piece
  attr_reader :value, :color, :type

  def initialize(pos, board, color)
    @board = board
    @pos = pos
    @type = "#"
    @color = color
  end

  def moves

  end

  def to_s
    @type
  end

end
