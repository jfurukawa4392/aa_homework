require_relative 'piece'
require 'sliding_piece'

class Rook < Piece
  include SlidingPiece

  def initialize(pos, board, color)
    @type = :R
    super
  end

  def moves
    find_moves
  end

  def move_dirs
    SlidingPiece::HORIZONTAL
  end

end
