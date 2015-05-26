(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function (xDim, yDim) {
    this.xDim = xDim;
    this.yDim = yDim;
    this.asteroids = [];

    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      this.addAsteroids();
    }
  };

  Game.X_DIM = 1000;
  Game.Y_DIM = 1000;
  Game.NUM_ASTEROIDS = 5;

  Game.prototype.addAsteroids = function () {
    var newAsteroid = new Asteroids.Asteroid({
      pos: this.randomPosition(),
      game: this
    });

    this.asteroids.push(newAsteroid);
  };

  Game.prototype.randomPosition = function () {
    var randX = Math.floor(Math.random() * this.xDim);
    var randY = Math.floor(Math.random() * this.yDim);

    return [randX, randY];
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, this.xDim, this.yDim);

    this.asteroids.forEach(function (asteroid) {
      asteroid.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.asteroids.forEach(function (asteroid) {
      asteroid.move();
    });
  };

  Game.prototype.wrap = function (pos) {
    pos[0] = (pos[0] + this.xDim) % this.xDim;
    pos[1] = (pos[1] + this.yDim) % this.yDim;

    return pos;
  };

})();
