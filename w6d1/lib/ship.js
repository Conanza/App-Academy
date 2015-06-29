(function () {
  if (typeof Asteroids === "undefined") {
      window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (attrs) {
    Asteroids.MovingObject.call(this, {
      pos: attrs.pos,
      vel: [0, 0],
      game: attrs.game,
      radius: Ship.RADIUS,
      color: Ship.COLOR
    });
  };

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.COLOR = "red";
  Ship.RADIUS = 20;

  Ship.prototype.relocate = function () {
    this.pos = this.game.randomPosition();
    this.vel = [0, 0];
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  Ship.prototype.fireBullet = function () {
    var ship = this;
    var bullet = new Asteroids.Bullet({
      pos: ship.pos,
      vel: ship.vel,
      game: ship.game
    });

    this.game.add(bullet);
  };

})();
