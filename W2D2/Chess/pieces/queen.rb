require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPiece

  def initialize(pos, board, color)
    @type = :Q
    super
  end

  def moves
    find_moves
  end

  def move_dirs
    SlidingPiece::DIAGONAL + SlidingPiece::HORIZONTAL
  end

end
