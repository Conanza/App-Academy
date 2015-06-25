Array.prototype.myEach = function (callback) {
  for (i = 0; i < this.length; i++) {
    callback(this[i]);
  }

  return this;
};

// function double (num) {
//   console.log(num * 2);
// }
// [1,2,3].myEach(double);

Array.prototype.myMap = function (callback) {
  var newArray = [];
  this.myEach(function (el) {
    newArray.push(callback(el));
  });

  return newArray;
};

// function triple (num) {
//   return (num * 3);
// }
// console.log([1,2,3].myMap(triple));

Array.prototype.myInject = function (callback) {
  var accumulator = this[0];

  this.slice(1).myEach(function (el) {
    accumulator = callback(accumulator, el);
  });

  return accumulator;
};

// function sum (x, y) {
//   return (x + 3 * y);
// }
// console.log([1,2,3,4].myInject(sum));

Array.prototype.bubbleSort = function () {
  var sorted = true;

  for (i = 1; i < this.length; i++) {
    var prevNum = this[i - 1];
    var currNum = this[i];

    if (prevNum > currNum) {
      this[i] = prevNum;
      this[i - 1] = currNum;

      sorted = false;
    }
  }

  if (!sorted) {
    return this.bubbleSort();
  } else {
    return this;
  }
};

// console.log([3,2,5,6,2,323,0].bubbleSort());

var substrings = function (string) {
  var subs = [];

  string.split("").forEach(function (letter, i) {
    for (j = i + 1; j <= string.length; j++) {
      subs.push(string.slice(i, j));
    }
  });

  return subs;
};

// console.log(substrings("cat"));
