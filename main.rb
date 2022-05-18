class Tree
  attr_accessor :root, :array

  def initialize(array)
    @root = nil
    @array = array
  end

  def build_tree(array)
    # base case is wrong somehow, its stackoverflow on line 18
    return if array.length <= 0

    # set middle value to root
    mid = (array.length / 2)
    node = Node.new(array[mid])

    # RECURSIVE
    node.left = build_tree(array[0..mid - 1])
    node.right = build_tree(array[mid + 1..-1])
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

array = [1, 9, 2, 3, 6, 5]
tree = Tree.new(array)
tree.build_tree(array.sort)
# Algorithm
# 1. Get an array
# 2. Find midpoint of array
# 3. Set midpoint to root
# 4. recursively find midpoint of left side and right side
# 5. steps 2-4
