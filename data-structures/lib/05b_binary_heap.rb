class BinaryHeap
  def self.child_indices(parent_idx, len)
    child1 = parent_idx * 2 + 1
    child2 = parent_idx * 2 + 2

    [child1, child2].select { |idx| idx < len }
  end

  def self.heapify_down(array, parent_idx, &prc)
    prc = prc || Proc.new { |el1, el2| el1 <=> el2 }

    c1_idx, c2_idx = child_indices(parent_idx, array.length)

    parent_val = array[parent_idx]
    children = []
    children << array[c1_idx] if c1_idx
    children << array[c2_idx] if c2_idx

    if children.all? { |child_val| prc.call(parent_val, child_val) <= 0 }
      return array
    end

    swap_idx = if children.length == 1
      c1_idx
    else
      prc.call(children[0], children[1]) == -1 ? c1_idx : c2_idx
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], parent_val
    heapify_down(array, swap_idx, &prc)
  end

  def self.heapify_up(array, child_idx, &prc)
    return array if child_idx == 0

    prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
    parent_idx = parent_index(child_idx)
    child_val, parent_val = array[child_idx], array[parent_idx]

    if prc.call(parent_val, child_val) <= 0
      return array
    else
      array[parent_idx], array[child_idx] = child_val, parent_val

      heapify_up(array, parent_idx, &prc)
    end
  end

  def self.parent_index(child_idx)
    raise "root has no parent" if child_idx == 0
    (child_idx - 1) / 2
  end

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    self.class.heapify_up(@store, @store.length - 1, &@prc)
  end

  def shift
    return nil if @store.length == 0
    val = @store[0]

    if @store.length > 1
      @store[0] = @store.pop
      self.class.heapify_down(@store, 0, &@prc)
    else
      @store.pop
    end

    val
  end
end
