# a self balancing binary search tree aka AVL tree
class Object
  def try(method, *args)
    self && self.send(method, *args)
  end
end

class AVLTreeNode
  attr_accessor :parent, :left, :right, :depth, :value

  def initialize(value)
    @value = value
    @depth = 1
  end

  def balance
    (right.try(:depth) || 0) - (left.try(:depth) || 0)
  end

  def balanced?
    balance.abs < 2
  end

  def parent_side
    return nil unless parent
    parent.left == self ? :left : :right
  end

  def recalculate_depth!
    self.depth = 1 + [
      left.try(:depth) || 0,
      right.try(:depth) || 0
    ].max
  end
end

class AVLTree
  def initialize
    @root = nil
  end

  def empty?
    @root.nil?
  end

  def include?(value)
    vertex, parent = find(value)
    !!vertex
  end

  def insert(value)
    if empty?
      @root = AVLTreeNode.new(value)
      return true
    end

    vertex, parent = find(value)
    return false if vertex

    vertex = AVLTreeNode.new(value)
    if value < parent.value
      parent.left = vertex
    else
      parent.right = vertex
    end
    vertex.parent = parent
    update(vertex)

    true
  end

  def traverse(vertex = @root, &prc)
    return if vertex.nil?

    traverse(vertex.left, &prc)
    prc.call(vertex.value, vertex)
    traverse(vertex.right, &prc)
  end

  private

  def find(value)
    vertex, parent = @root, nil

    until vertex.nil?
      break if vertex.value == value

      parent = vertex
      vertex = if value < parent.value
                 parent.left
               else
                 parent.right
               end
    end

    [vertex, parent]
  end

  def left_rotate!(parent)
    grandparent, grandparent_side = parent.parent, parent.parent_side
    right_child = parent.right
    right_left_child = right_child.try(:left)

    if grandparent && grandparent_side == :right
      grandparent.right = right_child
    elsif grandparent && grandparent_side == :left
      grandparent.left = right_child
    else
      @root = right_child
    end
    right_child.parent = grandparent

    right_child.left = parent
    parent.parent = right_child

    parent.right = right_left_child
    right_left_child.parent = parent if right_left_child

    parent.recalculate_depth!
  end

  def right_rotate!(parent)
    grandparent, grandparent_side = parent.parent, parent.parent_side
    left_child = parent.left
    left_right_child = left_child.try(:right)

    if grandparent && grandparent_side == :right
      grandparent.right = left_child
    elsif grandparent && grandparent_side == :left
      grandparent.left = left_child
    else
      @root = left_child
    end
    left_child.parent = grandparent

    left_child.right = parent
    parent.parent = left_child

    parent.left = left_right_child
    left_right_child.parent = parent if left_right_child

    parent.recalculate_depth!
  end

  def update(vertex)
    return if vertex.nil?

    if vertex.balance == -2
      left_rotate!(vertex.left) if vertex.left.balance == 1
      right_rotate!(vertex)
    elsif vertex.balance == 2
      right_rotate!(vertex.right) if vertex.right.balance == -1
      left_rotate!(vertex)
    elsif vertex.balance.abs < 2
      # balanced already, do nothing
    else
      raise "EHHH WUT"
    end

    vertex.recalculate_depth!
    update(vertex.parent)
  end
end
