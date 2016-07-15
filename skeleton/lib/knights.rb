require_relative '00_tree_node.rb'

class KnightPathFinder

  MOVE_DIRECTIONS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, 2], [2, 1], [1, -2], [2, -1]]

  def initialize(position=[0,0])
    @position = position
    @move_tree = nil
    @visited_positions = [position]
  end

  def build_move_tree(target_value)
    queue = [@position]
    new_root = PolyTreeNode.new(@position)
    until queue.empty?
      last = queue.shift
      return new_root.add_child(PolyTreeNode.new(last)) if last == target_value
      new_root = PolyTreeNode.new(last)
      new_move_positions(last).each do |move|
        queue << move
        new_root.add_child(PolyTreeNode.new(move))
      end
    end
  end

  def valid_moves(pos)
    valid_move_arr = []
    MOVE_DIRECTIONS.each do |move|
      x, y = pos
      x = x + move[0]
      y = y + move[1]
      valid_move_arr << [x, y] if x.between?(0,7) && y.between?(0,7)
    end
    valid_move_arr
  end

  def new_move_positions(pos)
    new_positions = valid_moves(pos).reject { |move| @visited_positions.include?(move) }
    @visited_positions << new_positions
    new_positions
  end

end
