(function () {
if(typeof Algorithms === "undefined") {
  window.Algorithms = {};
}

// Write a method, digital_root(num).
// It should sum the digits of a positive integer.
// If it is greater than or equal to 10, sum the digits of the resulting number.
// Keep repeating until there is only one digit in the result, called the "digital root".
// Do not use string conversion within your method.
Algorithms.digitalRoot = function (number) {
  if (number < 10) {
    return number;
  }

  var ones = number % 10;
  var remainder = Math.floor(number / 10);

  return Algorithms.digitalRoot(remainder + ones);
};

// Write a function that takes a message and an increment amount and outputs the same letters shifted by that amount in the alphabet.
// Assume lowercase and no punctuation.
// Preserve spaces.
Algorithms.caesarCipher = function (string, shift) {
  var letters = ["a", "b", "c", "d", "e", "f",
                 "g", "h", "i", "j", "k", "l", "m",
                 "n", "o", "p", "q", "r", "s", "t",
                 "u", "v", "w", "x", "y", "z"];
  var newString = [];

  string.split("").forEach(function (char) {
    if (letters.indexOf(char) !== -1) {
      newIdx = (letters.indexOf(char) + shift) % 26;
      newString.push(letters[newIdx]);
    } else {
      newString.push(char);
    }
  });

  return newString.join("");
};

// Write a function that takes two strings and returns the lenght of the longest common substring.
Algorithms.commonSubstrings = function (stringOne, stringTwo) {

};

// Write a function that takes an array of integers and returns their sum.
// Use recursion.
Algorithms.sumRec = function (numbers) {
  if (numbers.length === 0) {
    return 0;
  }

  return numbers[0] + Algorithms.sumRec(numbers.slice(1));
};

// Write a function which returns the first n elements from the fibonnacci sequence, given n.
Algorithms.fibs = function (number) {
  var fibs = [], i;
  for (i = 0; fibs.length < number; i++) {
    if (i === 0) {
      fibs.push(0);
    } else if (i === 1) {
      fibs.push(1);
    } else {
      fibs.push(fibs[fibs.length - 1] + fibs[fibs.length - 2]);
    }
  }

  return fibs;
};

// Write a function that takes a string and returns true if it's a palindrome, false if it's not.
// Your solution should take less time and memory than rebuilding the string backward and comparing the two.
Algorithms.isPalindrome = function (string) {
  for (var i = 0; i < Math.floor(string.length / 2); i++) {
    if (string[i] !== string[string.length - 1 - i]) {
      return false;
    }
  }

  return true;
};

// Implement the Folding Cipher.
// It folds the alphabet in half and uses the adjacent letter.
// a <=> z, b <=> y, c <=> x, m <=> n.
Algorithms.foldingCipher = function (string) {

};

// Write a method that finds all the unique substrings for a word.
Algorithms.uniqSubs = function (string) {

};


// Given an array of integers (positive and negative) find the largest contiguous subsum (sum of a subarray).
// You can solve this trivially in O(n**2) time by considering all subarrays.
// Try to solve it in O(n) time with O(1) memory.
Algorithms.lcs = function (array) {
  var maxSum;
  if (array.length === 0) {
    maxSum = 0;
  } else {
    maxSum = array[0];
  }

  var i, currentSum = maxSum;
  for (i = 1; i < array.length; i++) {
    currentSum += array[i];

    if (currentSum > maxSum) {
      maxSum = currentSum;
    } else if (currentSum < 0) {
      currentSum = 0;
    }
  }

  return maxSum;
};

// Write a function that takes a year (four digit integer) and returns an array with the 10 closest subsequent years that meet the following condition:
// the first two digits summed with the last two digits are equal to the middle two digits.
Algorithms.sillyYears = function (number) {

};

// Given an array of integers, return all pairs that sum up to a specified value k.
// List the pairs in [min, max] order.
// Time complexity: O(n).
// Return an array.
Algorithms.pairSum = function (array, k) {

};

// Given a matrix of integers and coordinates of a rectangular region within the matrix.
// Find the sum of numbers falling inside the rectangle.
// Time complexity: O(number of rows * number of columns).
Algorithms.matrixRegionSum = function (matrix, topLeftCoords, bottomRightCoords) {

};

})();
