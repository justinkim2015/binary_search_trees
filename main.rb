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
  def level_order 
    return if @root.nil?

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

  def pre_order(root, array = [])
    return if root.nil?

    array << root.data
    pre_order(root.left, array)
    pre_order(root.right, array)
    array
  end

  def in_order(root, array = [])
    return if root.nil?

    in_order(root.left, array)
    array << root.data
    in_order(root.right, array)
    array
  end

  def post_order(root, array = [])
    return if root.nil?

    post_order(root.left, array)
    post_order(root.right, array)
    array << root.data
    array
  end

  def insert(root, value)
    if root.nil?
      root = Node.new(value)
    elsif root.data == value
      root
    elsif root.data < value
      root.right = insert(root.right, value)
    elsif root.data > value
      root.left = insert(root.left, value)
    end
    root
  end

  def delete(root, value)
    return if root.nil?

    # binding.pry
    if value < root.data
      root.left = delete(root.left, value)
    elsif value > root.data
      root.right = delete(root.right, value)
    elsif root.left.nil?
      temp = root.right
      root = temp
    elsif root.right.nil?
      temp = root.left
      root = temp
    else
      temp = in_order(root.right).min
      root.data = temp
      root.right = delete(root.right, temp)
    end
    root
  end

  def find(root, value)
    return if root.nil?

    root if root.data == value

    node = find(root.left, value)
    if node.nil?
      node = find(root.right, value)
    end
    node
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
# tree.insert(tree.root, 10)
# tree.pretty_print
# tree.delete(tree.root, 5)
p tree.find(tree.root, 5)
# p tree.find_level_order(2)
