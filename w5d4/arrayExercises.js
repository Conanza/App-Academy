Array.prototype.myUniq = function () {
  var uniques = [];

  this.forEach(function(num) {
    if (uniques.indexOf(num) === -1) {
      uniques.push(num);
    }
  });

  return uniques;
};

Array.prototype.twoSum = function () {
  var pairs = [];

  this.forEach(function(num1, i) {
    for (var j = i + 1; j < this.length; j++) {
      var num2 = this[j];

      if (num1 + num2 === 0) {
        pairs.push([i, j]);
      }
    }
  }.bind(this));

  return pairs;
};


Array.prototype.transpose = function () {
  var newArray = [];

  for (i = 0; i < this.length; i++) {
    var newRow = [];
    for (j = 0; j < this.length; j++) {
      newRow.push(this[j][i]);
    }
    newArray.push(newRow);
  }

  return newArray;
};

console.log("myUniq test:");
console.log([1,2,3,4,5,5,6,6,6,6,6,6].myUniq());
console.log("twoSum test:");
console.log([-1, 0, 2, -2, 1].twoSum());

var matrix = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];
console.log("transpose test:");
console.log(matrix.transpose());
