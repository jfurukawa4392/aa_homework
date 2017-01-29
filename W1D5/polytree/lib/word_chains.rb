require 'set'
require 'byebug'
require_relative '00_tree_node'

class WordChainer

  def initialize(dictionary_file_name = '../dictionary.txt')
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end

  def adjacent_words(word)
    adjacent_words = Set[]
    (0...word.size).each do |i|
      ("a".."z").each do |char|
        copy = word.dup

        copy[i] = char
        adjacent_words << copy if @dictionary.include?(copy)
      end
    end

    adjacent_words.to_a
  end

  def build_word_tree(root)
    @root = PolyTreeNode.new(root)
    @all_seen_words = [root]
    queue = [@root]
    until queue.empty?
      this_node = queue.shift
      words = adjacent_words(this_node.value)
      words.reject! { |word| @all_seen_words.include?(word) }
      @all_seen_words.concat(words)
      nodes = words.map { |word| PolyTreeNode.new(word) }
      nodes.each { |node| node.parent = this_node }
      queue.concat(nodes)
    end
  end

  def build_path(target)
    result = @root.bfs(target)
    return unless result
    path = []
    this_node = result
    until this_node.parent.nil?
      path.unshift(this_node.value)
      this_node = this_node.parent
    end
    path.unshift(this_node.value)
  end


end
