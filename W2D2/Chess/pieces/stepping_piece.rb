module SteppingPiece
  KING = [[-1, -1], [-1, 1], [1, -1], [1, 1],
            [-1, 0], [0, 1], [0, -1], [1, 0]]
  KNIGHT = [[-2, -1], [-2, 1], [-1, 2], [1, 2],
            [2, 1], [2, -1], [1, -2], [-1, -2]]

  def find_moves
    legal_moves = []
    dirs = move_dirs

    dirs.each do |dir|
      new_pos = @pos.dup
      new_pos[0] += dir[0]
      new_pos[1] += dir[1]
      next unless @board.in_bounds?(new_pos)
      hit_piece_color = @board[new_pos].color
      legal_moves << new_pos.dup unless @color == hit_piece_color
    end

    legal_moves
  end
end
