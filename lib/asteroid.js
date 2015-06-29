(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroid = Asteroids.Asteroid = function (attrs) {
    Asteroids.MovingObject.call(this, {
      pos: attrs.pos,
      vel: Asteroids.Util.randomVec(Asteroid.RADIUS),
      radius: Asteroid.RADIUS,
      color: Asteroid.COLOR,
      game: attrs.game
    });
  };

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

  Asteroid.COLOR = "black";
  Asteroid.RADIUS = 40;

  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }
  };

})();
