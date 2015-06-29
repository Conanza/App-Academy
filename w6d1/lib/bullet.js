(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Bullet = Asteroids.Bullet = function (attrs) {
    Asteroids.MovingObject.call(this, {
      pos: attrs.pos,
      vel: attrs.vel,
      game: attrs.game,
      radius: Bullet.RADIUS,
      color: Bullet.COLOR
    });
  };

  Bullet.COLOR = "red";
  Bullet.RADIUS = 10;

  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);

})();
