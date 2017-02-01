require 'byebug'
require_relative 'pieces/pieces'

class Board
  attr_reader :grid

  ROWS_WITH_PIECES = [0, 1, 6, 7]

  def initialize
    @grid = build_grid
  end

  def build_grid
    base_board = Array.new(8) { [] }
    base_board.each_index do |idx|
      # byebug
      if ROWS_WITH_PIECES.include?(idx)
        case idx
        when 0, 7
          #place back black
          base_board[idx] = place_back_row(idx)
        when 1, 6
          base_board[idx] = place_pawns(idx)
        end
      else
        8.times do
          base_board[idx] << NullPiece.instance
        end
      end
    end
    # byebug
    base_board
  end

  def move_piece(start_pos, end_pos)
    # byebug
    piece = self[start_pos]
    raise TypeError if piece.type.nil?
    raise ArgumentError unless self[start_pos].moves.include?(end_pos)
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
    true
  end

  def in_check?(color)
    enemy_pieces = []
    king_pos = []
    @grid.each do |row|
      row.each do |piece|
        p_color = piece.color
        king_pos += piece.pos if p_color == color && piece.type == :K
        enemy_pieces << piece if p_color != color && !p_color.nil?
      end
    end
    # byebug
    enemy_pieces.each do |enemy|
      return true if enemy.moves.include?(king_pos)
    end

    false
  end

  def checkmate?(color)
    if in_check?(color)
      valid_moves = []
      get_my_pieces(color).each do |piece|
        valid_moves << piece.valid_moves
      end
      valid_moves.flatten.empty?
    else
      return false
    end
  end

  def get_my_pieces(color)
    my_pieces = []
    @grid.each do |row|
      row.each do |piece|
        my_pieces << piece if piece.color == color
      end
    end

    my_pieces
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def place_pawns(row_idx)
    color = row_idx == 1 ? :black : :white
    pawn_row = []

    (0..7).each do |col_idx|
      pawn_row << Pawn.new([row_idx, col_idx], self, color)
    end

    pawn_row
  end

  def place_back_row(row_idx)
    color = row_idx == 0 ? :black : :white
    back_row = []

    (0..7).each do |col_idx|
      pos = [row_idx, col_idx]
      case col_idx
      when 0, 7
        back_row << Rook.new(pos, self, color)
      when 1, 6
        back_row << Knight.new(pos, self, color)
      when 2, 5
        back_row << Bishop.new(pos, self, color)
      when 3
        back_row << Queen.new(pos, self, color)
      when 4
        back_row << King.new(pos, self, color)
      end
    end

    color == :white ? back_row.reverse : back_row
  end

  def in_bounds?(pos)
    pos.all? { |el| el >= 0 && el < 8 }
  end

  def dup
    Marshal.load(Marshal.dump(self))
  end

end
b = Board.new
# b.move_piece([6,5],[5,5])
# b.move_piece([7,1],[5,0])
