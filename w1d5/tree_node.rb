class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def add_child(node)
    node.parent = self
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if target_value == current_node.value
      queue += current_node.children
    end

    nil
  end

  def dfs(target_value)
    return self if target_value == value

    children.each do |child|
      search = child.dfs(target_value)
      return search if search
    end

    nil
  end

  def parent=(node)
    parent.children.delete(self) unless parent.nil?

    @parent = node

    node.children << self unless node.nil? || node.children.include?(self)
  end

  def remove_child(node)
    raise "Node is not a child!" unless children.include?(node)
    node.parent = nil
  end

  def trace_path_back
    return [self.value] if self.parent.nil?
    self.parent.trace_path_back + [self.value]
  end
end
