require 'pry'

class Tree
  attr_accessor :root, :array

  def initialize(array)
    @root = nil
    @left = nil
    @right = nil
    @array = array
  end

  def build_tree(array, start, finish)
    # base case is wrong somehow, its stackoverflow on line 18
    return if start > finish

    # set middle value to root
    mid = (start + finish) / 2 
    node = Node.new(array[mid])

    # RECURSIVE
    binding.pry
    node.left = build_tree(array[0..mid - 1], start, mid - 1)
    node.right = build_tree(array[mid + 1..-1], start, mid - 1) # this is broken

    node
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

array = [1, 2, 3, 5, 6, 7, 9]
mid = 3
tree = Tree.new(array)
last_index = array.length - 1 # 6
tree.build_tree(array, 0, last_index)
