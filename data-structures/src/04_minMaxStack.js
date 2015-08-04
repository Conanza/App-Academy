// A stack class with O(1) max and min methods

var MinMaxStack = function () {
  this.store = [];
};

MinMaxStack.prototype.length = function () {
  return this.store.length;
};

MinMaxStack.prototype.max = function () {
  if (this.store.length === 0) {
    return undefined;
  } else {
    return this.store[this.store.length - 1][1];
  }
};

MinMaxStack.prototype.min = function () {
  if (this.store.length === 0) {
    return undefined;
  } else {
    return this.store[this.store.length - 1][2];
  }
};

MinMaxStack.prototype.pop = function () {
  if (this.store.length === 0) {
    return undefined;
  } else {
    return this.store.pop()[0];
  }
};

MinMaxStack.prototype.push = function (value) {
  if (this.store.length === 0) {
    this.store.push([value, value, value]);
  } else {
    this.store.push([
      value,
      Math.max(value, this.max()),
      Math.min(value, this.min())
    ]);
  }

  return value;
};

module.exports = MinMaxStack;
