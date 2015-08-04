// var MinMaxStack = require("./04_minMaxStack.js");

function MinMaxQueue() {
  this.in = new MinMaxStack();
  this.out = new MinMaxStack();
}

MinMaxQueue.prototype.flip = function() {
  for (var i = 0, n = this.in.length(); i < n; i++) {
    this.out.push(this.in.pop());
  }

  return;
};

MinMaxQueue.prototype.max = function() {
  if (this.in.length() === 0) {
    return this.out.max();
  } else if (this.out.length() === 0) {
    return this.in.max();
  } else {
    return Math.max(
      this.in.max(),
      this.out.max()
    );
  }
};

MinMaxQueue.prototype.min = function() {
  if (this.in.length() === 0) {
    return this.out.min();
  } else if (this.out.length() === 0) {
    return this.in.min();
  } else {
    return Math.min(
      this.in.min(),
      this.out.min()
    );
  }
};

MinMaxQueue.prototype.push = function(value) {
  return this.in.push(value);
};

MinMaxQueue.prototype.shift = function() {
  if (this.out.length() === 0) {
    this.flip();
  }

  return this.out.pop();
};
