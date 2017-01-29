class PolyTreeNode

  attr_reader :value, :children, :parent

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def parent=(node)
    if @parent
      return @parent if node == @parent
      @parent.children.delete(self)
    end
    @parent = node
    node.children << self unless node.nil?
    @parent
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'not a child' unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if @value == target
    @children.each do |child|
      result = child.dfs(target)
      return result if result
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      queue += current_node.children
    end

    nil
  end
end
