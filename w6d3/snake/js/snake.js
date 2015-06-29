(function () {
  if (typeof SnakeGame === 'undefined') {
    window.SnakeGame = {};
  }

  var Snake = SnakeGame.Snake = function () {
    this.dir = "S";
    this.segments = [[7, 10], [6, 10], [5, 10]];
  };

  Snake.DIRS = {"N": [-1, 0],
                "E": [0, 1],
                "S": [1, 0],
                "W": [0, -1]};

  Snake.prototype.move = function () {
    this.segments.pop();
    var previousHead = this.segments[0];
    var currentDirection = Snake.DIRS[this.dir];
    var newPos = SnakeGame.Coord.plus(previousHead, currentDirection);
    if (this.validMove(newPos)) {
      this.segments.unshift(newPos);
    } else {
      alert("You lose!");
    }
  };

  Snake.prototype.turn = function (newDir) {
    this.dir = newDir;
  };

  Snake.prototype.validMove = function (pos) {
    if (pos[0] < 0 || pos[0] > 19) {
      return false;
    } else if (pos[1] < 0 || pos[1] > 19) {
      return false;
    } else if (this.segments.some(function(segment) {
      return SnakeGame.Coord.equals(segment, pos);
    })) {
      return false;
    }

    return true;
  };

})();
