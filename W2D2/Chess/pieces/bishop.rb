require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece
  include SlidingPiece

  def initialize(pos, board, color)
    @type = :B
    super
  end

  def moves
    find_moves
  end

  def move_dirs
    SlidingPiece::DIAGONAL
  end

end
