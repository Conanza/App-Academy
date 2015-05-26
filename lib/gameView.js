(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function (ctx, game) {
    this.game = game;
    this.ctx = ctx;
  };

  GameView.prototype.start = function () {
    window.setInterval((function () {
      this.game.step();
      this.game.draw(this.ctx);
    }).bind(this), 1000/60);

    this.bindKeyHandlers();
  };

  GameView.prototype.bindKeyHandlers = function () {
    var ship = this.game.ship;
    key("up",    function() { ship.power([ 0, -1]); });
    key("down",  function() { ship.power([ 0,  1]); });
    key("right", function() { ship.power([ 1,  0]); });
    key("left",  function() { ship.power([-1,  0]); });

  };
})();
