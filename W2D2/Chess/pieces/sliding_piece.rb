module SlidingPiece
  DIAGONAL = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  HORIZONTAL = [[-1, 0], [0, 1], [0, -1], [1, 0]]


  def find_moves
    legal_moves = []
    dirs = move_dirs

    dirs.each do |dir|
      new_pos = @pos.dup
      hit_piece = false

      until hit_piece
        new_pos[0] += dir[0]
        new_pos[1] += dir[1]
        break unless @board.in_bounds?(new_pos)
        hit_piece = @board[new_pos]
        case hit_piece.color
        when self.color
          #friendly
          hit_piece = true
        when nil #null piece
          legal_moves << new_pos.dup
          hit_piece = false
        else
          legal_moves << new_pos.dup
          hit_piece = true
        end
      end
    end

    legal_moves
  end
end
