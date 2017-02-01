require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece

  def initialize(pos, board, color)
    super
    @type = :H
  end

  def moves
    find_moves
  end

  def move_dirs
    SteppingPiece::KNIGHT
  end

end
