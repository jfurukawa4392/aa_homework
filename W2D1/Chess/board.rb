require 'byebug'
require_relative 'piece.rb'
require_relative 'rook'

class Board
  attr_reader :grid

  ROWS_WITH_PIECES = [0,1,6,7]

  def initialize
    @grid = build_grid
  end

  def build_grid
    base_board = Array.new(8) { Array.new(8) }
    base_board.each_with_index do |row, idx|
      if ROWS_WITH_PIECES.include?(idx)
        row.each_with_index do |space, space_idx|
          base_board[idx][space_idx] = Rook.new
        end
      else
        row.each_with_index do |space, space_idx|
          base_board[idx][space_idx] = NullPiece.instance
        end
      end
    end

    base_board
  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError unless in_bounds?(start_pos) && in_bounds?(end_pos)
    piece = self[start_pos]
    raise TypeError if piece.nil?
    self[end_pos] = piece
    self[start_pos] = nil
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def put_pieces(row, type)
  end

  def in_bounds?(pos)
    pos.all? { |el| el >= 0 && el < 8 }
  end

end

b = Board.new
# byebug
p b[1,0].moves
p b.grid
