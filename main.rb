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

  def level_order
    return if @root.nil?

    queue = []
    array = []
    queue.unshift @root
    until queue.empty?
      current = queue[0]
      if block_given?
        yield current.data
      else
        array << current.data
      end
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
      queue.shift
    end
    array unless block_given?
  end

  # Block is only being passed to the first version of the recursion
  # Figure out how to pass the block as a parameter into the recursion (&?)
  def pre_order(root, array = [], block = nil)
    return if root.nil?

    if !block.nil?
      block.call(root.data)
      pre_order(root.left, [], block)
      pre_order(root.right, [], block)
    else
      array << root.data
      pre_order(root.left, array)
      pre_order(root.right, array)
      array
    end
  end

  def in_order(root, array = [], block = nil)
    return if root.nil?

    if !block.nil?
      in_order(root.left, [], block)
      block.call(root.data)
      in_order(root.right, [], block)
    else
      in_order(root.left, array)
      array << root.data
      in_order(root.right, array)
      array
    end
  end

  def post_order(root, array = [], block = nil)
    return if root.nil?

    if !block.nil?
      post_order(root.left, [], block)
      post_order(root.right, [], block)
      block.call(root.data)
    else
      post_order(root.left, array)
      post_order(root.right, array)
      array << root.data
      array
    end
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

  def height(root)
    return -1 if root.nil?

    max_l = height(root.left)
    max_r = height(root.right)
    if max_l > max_r
      max_l + 1
    else
      max_r + 1
    end
  end

  def 
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
tree = Tree.new(arr)
# tree.pretty_print
# lambda = ->(num) { puts "number is #{num}"}
# tree.pre_order(tree.root, [], lambda)
# tree.in_order(tree.root, [], lambda)
# tree.post_order(tree.root, [], lambda)
p "Height of tree is #{tree.height(tree.root)}"
p "Depth of tree is #{tree.depth(tree.root)}"
