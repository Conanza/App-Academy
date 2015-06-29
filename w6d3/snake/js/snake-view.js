(function () {
  if (typeof SnakeGame === 'undefined') {
    window.SnakeGame = {};
  }

  var View = SnakeGame.View = function ($el) {
    this.$el = $el;
    this.board = new SnakeGame.Board();
    this.snake = this.board.snake;
    this.setupBoard();
    this.bindEvents();
    setInterval(this.step.bind(this), 200);
  };

  View.KEYCODES = {
    '37': 'W',
    '38': 'N',
    '39': 'E',
    '40': 'S'
  };

  View.prototype.bindEvents = function () {
    $('body').on("keydown", this.handleKeyEvent.bind(this));
  };

  View.prototype.handleKeyEvent = function (event) {
    var dir = View.KEYCODES[event.keyCode];
    this.board.snake.turn(dir);
  };

  View.prototype.render = function () {
    $('div').removeClass("snake");

    this.snake.segments.forEach( function(segment) {
      $('.box').each( function(index, el) {
        var divPos = $(el).data("pos");

        if (SnakeGame.Coord.equals(divPos, segment)) {
          $(el).addClass("snake");
        }
      });
    });
  };

  View.prototype.step = function () {
    this.board.snake.move();
    this.render();
  };

  View.prototype.setupBoard = function () {
    for (var i = 0; i < 20; i++) {
      var $row = $('<div>').addClass("row group").appendTo(this.$el);

      for (var j = 0; j < 20; j++) {
        var pos = [i, j];
        var $box = $('<div>').addClass("box").appendTo($row);
        $box.data("pos", pos);
      }
    }
  };


})();
