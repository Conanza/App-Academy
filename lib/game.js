(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function (xDim, yDim) {
    this.xDim = xDim;
    this.yDim = yDim;
    this.asteroids = [];
    this.bullets = [];
    this.addAsteroids();

    this.ship = new Asteroids.Ship({
      game: this,
      pos: this.randomPosition()
    });
  };

  Game.X_DIM = 1000;
  Game.Y_DIM = 1000;
  Game.NUM_ASTEROIDS = 5;

  Game.prototype.add = function (obj) {
    this.bullets.push(obj);

  };

  Game.prototype.remove = function (asteroid) {
    var roidIdx = this.asteroids.indexOf(asteroid);
    this.asteroids[roidIdx] = new Asteroids.Asteroid({
      game: this,
      pos: this.randomPosition()
    });
  };

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      var newAsteroid = new Asteroids.Asteroid({
        pos: this.randomPosition(),
        game: this
      });

      this.asteroids.push(newAsteroid);
    }
  };

  Game.prototype.randomPosition = function () {
    var randX = Math.floor(Math.random() * this.xDim);
    var randY = Math.floor(Math.random() * this.yDim);

    return [randX, randY];
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, this.xDim, this.yDim);

    this.allObjects().forEach(function (object) {
      object.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.allObjects().forEach(function (object) {
      object.move();
    });
  };

  Game.prototype.wrap = function (pos) {
    pos[0] = (pos[0] + this.xDim) % this.xDim;
    pos[1] = (pos[1] + this.yDim) % this.yDim;

    return pos;
  };

  Game.prototype.checkCollisions = function () {
    for (var i = 0; i < this.allObjects().length; i++) {
      for (var j = i + 1; j < this.allObjects().length; j++) {
        if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])) {
          console.log("COLLISION");
          this.allObjects()[i].collideWith(this.allObjects()[j]);
        }
      }
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.allObjects = function () {
    return this.asteroids.concat(this.bullets, [this.ship]);
  };
})();
