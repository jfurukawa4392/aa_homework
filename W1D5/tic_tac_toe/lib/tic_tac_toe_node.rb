require 'byebug'
require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark = :x, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      @board.winner && @board.winner != evaluator
    elsif evaluator == @next_mover_mark
      children.all? { |node| node.losing_node?(evaluator) }
    else
      children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      @board.winner == evaluator
    elsif evaluator == @next_mover_mark
      children.any? { |node| node.winning_node?(evaluator) }
    else
      children.all? { |node| node.winning_node?(evaluator) }
    end
  end

  def other_symbol
    if @next_mover_mark == :x
      :o
    else
      :x
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        moves << [i, j] if @board[[i, j]].nil?
      end
    end
    moves.map do |move|
      new_state = @board.dup
      new_state[move] = @next_mover_mark
      self.class.new(new_state, other_symbol, move)
    end
  end
end
