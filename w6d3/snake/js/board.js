(function () {
  if (typeof SnakeGame === 'undefined') {
    window.SnakeGame = {};
  }

  var Board = SnakeGame.Board = function () {
    this.snake = new SnakeGame.Snake();
    this.apples = [];
    // this.grid = [];
    // this.setupBoard();
  };

  // Board.prototype.render = function () {
  //   for (var row = 0; row < this.grid.length; row++) {
  //     var rowStr = "";
  //     var $bigdiv = $('<div>')
  //     var html = "<pre>"
  //
  //     for (var col = 0; col < this.grid.length; col++) {
  //       var pos = [row, col];
  //
  //       var snakePresence = this.snake.segments.some(function(segment) {
  //         return SnakeGame.Coord.equals(pos, segment)
  //       });
  //
  //       if (snakePresence) {
  //         html += "S";
  //       } else {
  //         html += ".";
  //       }
  //     }
  //
  //     html += "</pre>";
  //     $bigdiv.append(html);
  //   }
  //   $('body').append($bigdiv);
  // };

  Board.prototype.setupBoard = function () {
    for (var row = 0; row < 20; row++) {
      var rowArray = [];
      for (var col = 0; col < 20; col++) {
        rowArray.push('.');
      }
      this.grid.push(rowArray);
    }
  };
})();
