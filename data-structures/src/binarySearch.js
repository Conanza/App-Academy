// binary search O(1) memory with tail-call optimization

function binarySearch(array, target, start, len) {
  if (array.length === 0 || len === 0) {
    return null;
  }

  var start = start || 0;
  var len = len || array.length;
  var pivot_idx = start + Math.floor(len / 2);

  switch (sort(target, array[pivot_idx])) {
    case 0:
      return pivot_idx;
    case -1:
      return binarySearch(array, target, start, pivot_idx - start);
    case 1:
      return binarySearch(array, target, pivot_idx + 1, (start + len) - (pivot_idx + 1));
  }
}

function sort(num1, num2) {
  if (num1 < num2) {
    return -1;
  } else if (num1 > num2) {
    return 1;
  } else {
    return 0;
  }
}
