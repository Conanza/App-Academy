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

# TC: same as before, AVG O(nlogn)
# SC: O(logn)
def qsort!(arr, start = 0, len = arr.length)
  return arr if len <= 1

  pivot_idx = partition!(arr, start, len)
  qsort!(arr, start, pivot_idx - start)
  qsort!(arr, pivot_idx + 1, (start + len) - (pivot_idx + 1))

  arr
end

def partition!(arr, start, len)
  pivot_idx, pivot = start, arr[start]

  ((start + 1)...(start + len)).each do |idx|
    value = arr[idx]
    next if value >= pivot

    arr[idx] = arr[pivot_idx + 1]
    arr[pivot_idx + 1] = pivot
    arr[pivot_idx] = value

    pivot_idx += 1
  end

  pivot_idx
end
