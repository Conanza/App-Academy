# TC: O(nlogn)
# SC: O(n)
# Consistent performance
# Good if we have space for a copy our array
def merge_sort(array)
  return array if array.length <= 1

  midpoint = array.length / 2
  left = array[0...midpoint]
  right = array[midpoint...array.length]

  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  merged_array = []
  left_idx, right_idx = 0, 0
  until left_idx == left.length && right_idx == right.length
    if right_idx >= right.length || (left_idx < left.length && left[left_idx] <= right[right_idx])
      merged_array << left[left_idx]

      left_idx += 1
    else
      merged_array << right[right_idx]

      right_idx += 1
    end
  end

  merged_array
end
