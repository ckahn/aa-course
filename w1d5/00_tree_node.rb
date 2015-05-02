class PolyTreeNode
  attr_reader   :value, :parent, :children

  def initialize(value)
    @value    = value
    @parent   = nil
    @children = []
  end

  def add_child(child)
    child.parent = self
  end

  def bfs(target_value)
    return self if @value == target_value

    nodes_to_search = [self]
    until nodes_to_search.empty?
      first_node = nodes_to_search.shift
      return first_node if first_node.value == target_value
      first_node.children.each { |child| nodes_to_search << child }
    end
    nil
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def parent=(new_parent)
    @parent.children.delete(self) unless @parent.nil?
    unless new_parent.nil? || new_parent.children.include?(self)
      new_parent.children << self
    end
    @parent = new_parent
  end

  def remove_child(child)
    raise "Not a child!" unless @children.include?(child)

    child.parent = nil
    @children.delete(child)
  end

  def trace_path_back
    return [self.value] if @parent.nil?

    @parent.trace_path_back + [self.value]
  end
end
