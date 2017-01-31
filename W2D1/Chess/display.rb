require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    while true
      system('clear')
      p @cursor.cursor_pos
      @board.grid.each_with_index do |row, r_idx|
        row.each_with_index do |col, c_idx|
          if [r_idx, c_idx] == @cursor.cursor_pos
            print print_space([r_idx, c_idx]).colorize(:white).on_red.blink
          else
            print print_space([r_idx, c_idx])
          end
        end
        print "\n"
      end
      @cursor.get_input
    end
  end

  def print_space(pos)
    return @board[pos].nil? ? " " : @board[pos].to_s
  end
end

b = Board.new
d = Display.new(b)
d.render
