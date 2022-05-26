require_relative 'node'
require_relative 'tree'

array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)

tree.balanced?

tree.level_order

p tree.pre_order
p tree.in_order
p tree.post_order

100.times do
  tree.insert(tree.root, rand(100))
end

tree.balanced?
tree.rebalance
tree.balanced?

p tree.pre_order
p tree.in_order
p tree.post_order
