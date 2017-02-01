class Piece
  attr_reader :value, :color, :type, :pos


  def initialize(pos, board, color)
    @board = board
    @pos = pos
    @color = color
  end

  def moves
  end

  def valid_moves
    valid_moves = []

    moves.each do |move|
      dup = @board.dup
      dup.move_piece(@pos, move)
      valid_moves << move unless dup.in_check?(@color)
    end

    valid_moves
  end

  def to_s
    @type.to_s
  end

end
