require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    node.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    nonlosers = node.children.reject { |child| child.losing_node?(mark) }
    raise 'wut' if nonlosers.empty?
    nonlosers[0].prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
  
end
