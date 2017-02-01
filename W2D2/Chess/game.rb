require_relative 'board'
require_relative 'display'

class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @display = Display.new(@board)
    @current_player = player1
    @colors = { @player1 => :white, @player2 => :black }
  end

  def play
    until won?
      do_move
    end
  end

  def do_move
    master_moveset = []
    move_valid = false
    # byebug
    until move_valid
      p master_moveset
      begin
        get_input(master_moveset)

        next if master_moveset.size < 2
        move_valid = @board.move_piece(master_moveset[0], master_moveset[1])
      rescue ArgumentError => e
        #invalid move error message
        # e.msg
        master_moveset = []
        retry
      rescue TypeError => e
        #No piece at start position
        # e.msg
        master_moveset = []
        retry
      end
    end
  end

  def get_input(moveset)
    player_input = @display.render
    moveset << player_input.dup if player_input.size == 2
  end

  def won?
    @board.checkmate?(@colors[@current_player])
  end
end

g = Game.new("Jesse", "Michael")
g.play
