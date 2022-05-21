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

  # third loop is getting popped without getting read
  def bft 
    return if @root.nil?

    # binding.pry
    queue = []
    array = []
    queue.unshift @root
    until queue.empty?
      current = queue[0]
      array << current.data
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
      queue.shift
    end
    array
  end

  def dft(root, array = [])
    return if root.nil?

    # binding.pry
    dft(root.left, array)
    array << root.data
    dft(root.right, array)
    array
  end

  def insert(root, value)
    if root.nil?
      root = Node.new(value)
    else
      if root.data == value
        root
      elsif root.data < value
        root.right = insert(root.right, value)
      elsif root.data > value
        root.left = insert(root.left, value)
      end
    end
    root
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
# p tree.dft(tree.root)
tree.insert(tree.root, 10)
tree.pretty_print
