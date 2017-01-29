require 'set'
require_relative '../polytree/lib/00_tree_node'

class KnightPathFinder

  attr_reader :root

  DELTAS = [[-2, -1], [-2, 1],
            [-1, -2], [-1, 2],
            [1, -2], [1, 2],
            [2, -1], [2, 1]
          ]

  def initialize(pos)
    @root = PolyTreeNode.new(pos)
    @visited_pos = [pos]
  end

  def self.valid_moves(pos)
    moves = DELTAS.map do |(dx,dy)|
      [pos.first + dx, pos.last + dy]
    end

    moves.select do |move|
      move.first.between?(0,7) && move.last.between?(0,7)
    end
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    valid_moves.reject! { |move| @visited_pos.include?(move) }
    @visited_pos.concat(valid_moves)
    valid_moves
  end

  def build_move_tree
    queue = [@root]
    until queue.empty?
      this_node = queue.shift
      new_move_positions(this_node.value).each do |pos|
        node = PolyTreeNode.new(pos)
        node.parent = this_node
        queue << node
      end
    end
  end

  def find_path(end_pos)
    target_node = @root.dfs(end_pos)
    trace_path_back(target_node)
  end

  def trace_path_back(leaf_node)
    path = []
    this_node = leaf_node
    until this_node.parent.nil?
      path.unshift(this_node.value)
      this_node = this_node.parent
    end
    path.unshift(@root.value)
    path
  end
end

if __FILE__ == $PROGRAM_NAME
  k = KnightPathFinder.new([3, 3])
  k.build_move_tree
  p k.root.children.any? do |child|
    child.children.map { |grandchild| grandchild.value } ==
    [[0, 6], [0, 2], [3, 5], [2, 2], [2, 6]]
  end

  k2 = KnightPathFinder.new([0,0])
  k2.build_move_tree
  p k2.find_path([7,6])
  p k2.find_path([6,2])
end
