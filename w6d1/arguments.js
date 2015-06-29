function sum () {
  var total = 0;
  for (var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }

  return total;
}

// console.log(sum(1, 2, 3, 4) === 10);
// console.log(sum(1, 2, 3, 4, 5) === 15);

Function.prototype.myBind = function (context) {
  var fn = this;
  var args = Array.prototype.slice.call(arguments);
  args = args.slice(1);

  return function () {
    var moreArgs = Array.prototype.slice.call(arguments);
    moreArgs = args.concat(moreArgs);
    return fn.apply(context, moreArgs);
  };
};

// console.log(Function.prototype.sum.myBind(null, 1, 2, 3)(1, 2, 3));
// console.log(Array.prototype.slice.myBind([2,3,1,52,143], 1)(4));
// var arr = [1,2,3,4,5];
// console.log((Array.prototype.slice.myBind(arr, 0, 2))());

function curriedSum(numArgs) {
  var numbers = [];

  function _curriedSum (singleNumber) {
    numbers.push(singleNumber);

    if (numbers.length === numArgs) {
      var total = 0;
      for (var i = 0; i < numbers.length; i++) {
        total += numbers[i];
      }

      return total;
    } else {
      return _curriedSum;
    }
  }

  return _curriedSum;
}

// console.log(curriedSum(4)(1)(2)(3)(4));

Function.prototype.curry = function (numArgs) {
  var fn = this;
  var args = [];

  function innerCurry (singleArg) {
    args.push(singleArg);

    if (args.length == numArgs) {
      return fn.apply(null, args);
    } else {
      return innerCurry;
    }
  }

  return innerCurry;
};

// console.log(sum.curry(4)(1)(2)(3)(4));
