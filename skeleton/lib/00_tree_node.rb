require 'byebug'
class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end


  def parent=(node)
    # byebug
    @parent.children.delete(self) if @parent
    @parent = node
    @parent.children << self if node
  end

  def add_child(child)
    child.parent=(self) unless @children.include?(child)
  end

  def remove_child(child)
    raise "Not a child" unless @children.include?(child)
    @children.delete(child)
    child.parent=(nil)
  end

  def dfs(target)
    return self if @value == target

    @children.each do |child|
      child_result = child.dfs(target)

      return child_result if child_result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      first_node = queue.shift
      return first_node if first_node.value == target
      queue += first_node.children
    end
    nil 
  end

end

# node1 = [node2, node3]
#
# node4 = [node5 node6]
#
# node5.parent -> node4
# node5.parent = node1
