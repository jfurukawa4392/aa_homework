require 'byebug'
require_relative 'piece'

class Pawn < Piece

  WHITE = [[-1,1], [-1,0], [-1,1]]
  BLACK = [[1,-1], [1,0], [1,1]]

  def initialize(pos, board, color)
    @type = :P
    @moved = false
    super
  end

  def moves
    legal_moves = []
    dirs = move_dirs

    dirs.each do |dir|
      # byebug if dir == [1,-1]
      new_pos = @pos.dup
      new_pos[0] += dir[0]
      new_pos[1] += dir[1]
      next unless @board.in_bounds?(new_pos)
      hit_piece_color = @board[new_pos].color
      if !dir[1].zero?
        legal_moves << new_pos.dup if hit_piece_color == opposite_color
      elsif hit_piece_color.nil?
        legal_moves << new_pos.dup
      end
    end

    legal_moves
  end

  def move_dirs
    output = (self.color == :black ? BLACK.dup : WHITE.dup)

    output << (self.color == :black ? [2, 0] : [-2, 0]) unless moved? ||
      piece_ahead?

    output
  end

  def opposite_color
    @color == :black ? :white : :black
  end

  def piece_ahead?
    delta = (self.color == :black ? [1, 0] : [-1, 0])
    new_pos = adjust_pos(delta)
    !@board[new_pos].color.nil?
  end

  def adjust_pos(delta)
    # byebug
    new_pos = @pos.dup
    new_pos[0] += delta[0]
    new_pos[1] += delta[1]
    new_pos
  end

  def moved?
    @moved
  end

end
