require_relative '00_tree_node'

class KnightPathFinder
  KNIGHT_DIFFS = [
    [ 1,  2],
    [ 1, -2],
    [-1,  2],
    [-1, -2],
    [ 2,  1],
    [ 2, -1],
    [-2,  1],
    [-2, -1]
  ]

  def initialize(pos)
    @start_pos = pos
    @visited_positions = [pos]
  end

  def self.valid_moves(pos)
    x, y = pos[0], pos[1]

    moves = KNIGHT_DIFFS.map do |diff|
      new_x = x + diff[0]
      new_y = y + diff[1]
      [new_x, new_y]
    end

    moves.select do |move|
      move[0].between?(0, 7) && move[1].between?(0, 7)
    end
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(@start_pos)
    remaining_nodes = [@root_node]

    until remaining_nodes.empty?
      first_node = remaining_nodes.shift
      new_positions = new_move_positions(first_node.value)
      new_positions.each do |pos|
        child = PolyTreeNode.new(pos)
        child.parent = first_node
        remaining_nodes << child
      end
    end
  end

  def find_path(end_pos)
    end_node = @root_node.dfs(end_pos)
    end_node.trace_path_back
  end

  def new_move_positions(pos)
    new_positions = self.class.valid_moves(pos) - @visited_positions
    new_positions.each do |pos|
      @visited_positions << pos unless @visited_positions.include?(pos)
    end
    new_positions
  end
end
