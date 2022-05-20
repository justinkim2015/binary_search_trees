require 'pry'

class Tree
  attr_accessor :root, :array

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array, 0, @array.length - 1)
  end

  def build_tree(array, start, finish)
    return if start > finish

    mid = (start + finish) / 2
    node = Node.new(array[mid])
    node.left = build_tree(array[0..mid - 1], start, mid - 1)
    node.right = build_tree(array[mid + 1..-1], start, mid - 1)
    node
  end

  # still broken but getting there
  def bft 
    return if @root.nil?

    queue = []
    array = []
    queue << @root
    until queue.empty?
      current = queue[0]
      array << current.data
      queue.unshift current.left unless current.left.nil?
      queue.unshift current.right unless current.right.nil?
      queue.pop
    end
    array
  end

  def insert(value)
    current = @root
    nxt = @root
    until current.value == value
      current = nxt
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

arr = [1, 2, 3, 5, 6, 7, 9]
array = []
rand(10).times do
  array << rand(100)
end
tree = Tree.new(arr)
tree.pretty_print
tree.bft