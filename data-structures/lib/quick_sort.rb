# TC: AVG O(nlogn), WC: O(n^2)
# SC: O(n)
def bad_qsort(arr)
  return arr if arr.length <= 1

  pivot = arr.sample
  # O(n)
  left = arr.select { |el| el <= pivot }
  # O(n)
  right = arr.select { |el| el > pivot }

  bad_qsort(left) + bad_qsort(right)
end

def qsort(arr)
  return arr if arr.length <= 1
  pivot_idx = partition(arr)
  left = arr.take(pivot_idx)
  right = arr.drop(pivot_idx + 1)

  qsort(left) + [arr[pivot_idx]] + qsort(right)
end

def partition(arr)
  pivot_idx = rand(arr.length)
  arr[0], arr[pivot_idx] = arr[pivot_idx], arr[0]

  pivot_idx, i = 0, 1
  until i == arr.length
    if arr[i] >= arr[pivot_idx]
      i += 1
      next
    end

    pivot = arr[pivot_idx]
    arr[pivot_idx] = arr[i]
    arr[i] = arr[pivot_idx + 1]
    arr[pivot_idx + 1] = pivot

    pivot_idx += 1
    i += 1
  end

  pivot_idx
end
