require 'byebug'
require_relative '00_tree_node'

class KnightPathFinder

  def self.valid_moves(pos)
    positions = [
      [pos[0], pos[1] + 1],
      [pos[0], pos[1] - 1 ],
      [pos[0] + 1, pos[1]],
      [pos[0] - 1, pos[1]],
      [pos[0] - 1, pos[1] + 1],
      [pos[0] - 1, pos[1] - 1],
      [pos[0] + 1, pos[1] + 1],
      [pos[0] + 1, pos[1] - 1]
    ]

    # x = pos[0]
    # y = pos[1]
    # (x-1..x+1).each do |i|
    #   (y-1..y+1).each do |j|
    #
    #   end
    # end
    positions.reject { |pos| pos.any? { |num| num < 0 || num > 7} }
  end

  def build_move_tree
    queue = [PolyTreeNode.new(@root)]
    new_tree = [queue.first]
    until queue.empty?
      current_node = queue.shift
      children_pos = new_move_positions(current_node.value)
      children_pos.each do |child|
        new_node = PolyTreeNode.new(child)
        new_node.parent=(current_node)
        queue << new_node
        new_tree << new_node
      end
    end
    new_tree
  end

  attr_reader :tree

  def initialize(root = [0,0])
    @root = root
    @visited_positions = [@root]
    @tree = build_move_tree
  end

  def new_move_positions(pos)
    adjacadent = self.class.valid_moves(pos)
    adjacadent = adjacadent.reject { |node| @visited_positions.include?(node) }
    @visited_positions += adjacadent
    adjacadent
  end

  def find_path(end_pos)
      target_node = @tree.first.bfs(end_pos)
      trace_path_back(target_node)
  end

  def trace_path_back(target_node)
    path = [target_node.value]
    loop do
      byebug
      current_node = target_node.parent
      target_node = current_node
      path << current_node.value
      return path if current_node == @tree.first
    end
  end

end

knight = KnightPathFinder.new
knight.build_move_tree
p knight.find_path([7,7])
