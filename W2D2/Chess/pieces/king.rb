require_relative 'piece'
require_relative 'stepping_piece'

class King < Piece
  include SteppingPiece

  def initialize(pos, board, color)
    @type = :K
    super
  end

  def moves
    find_moves
  end

  def move_dirs
    SteppingPiece::KING
  end

end
