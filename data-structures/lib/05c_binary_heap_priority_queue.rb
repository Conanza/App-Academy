class BinHeapPriorityQueue
  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def length
    @store.length
  end

  def peek
    raise "there's nothing to see" if length == 0
    @store[0]
  end

  # the time complexity of heapifying is O(d), where d is the depth of the tree
  # if n is the # of vertices
  # we know n = 2^d - 1
  # TC: O(log n)
  def push(val, priority)
    @store << [val, priority]
    heapify_up(@store, length - 1)

    self
  end

  # TC: O(log n)
  def shift
    raise "nothing in queue" if length == 0
    val = @store[0][0]

    if length > 1
      @store[0] = @store.pop
      heapify_down(@store, 0)
    else
      @store.pop
    end

    val
  end

  private

  def children_indices(par_idx)
    c1_idx = par_idx * 2 + 1
    c2_idx = par_idx * 2 + 2

    [c1_idx, c2_idx].select { |idx| idx < length }
  end

  def heapify_down(array, par_idx)
    c1_idx, c2_idx = children_indices(par_idx)

    par_priority = array[par_idx][1]
    children = []
    children << array[c1_idx] if c1_idx
    children << array[c2_idx] if c2_idx

    if children.all? { |val, priority| @prc.call(par_priority, priority) <= 0 }
      return array
    end

    swap_idx = if children.length == 1
                 c1_idx
               else
                 @prc.call(array[c1_idx][1], array[c2_idx][1]) <= 0 ? c1_idx : c2_idx
               end

    array[par_idx], array[swap_idx] = array[swap_idx], array[par_idx]
    heapify_down(array, swap_idx)
  end

  def heapify_up(array, child_idx)
    return array if child_idx == 0

    par_idx = parent_index(child_idx)
    par_priority, child_priority = array[par_idx][1], array[child_idx][1]

    if @prc.call(par_priority, child_priority) <= 0
      return array
    else
      array[par_idx], array[child_idx] = array[child_idx], array[par_idx]
      heapify_up(array, par_idx)
    end
  end

  def parent_index(child_idx)
    raise "root has no parent" if child_idx == 0
    (child_idx - 1) / 2
  end
end
