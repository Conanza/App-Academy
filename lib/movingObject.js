(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var MovingObject = Asteroids.MovingObject = function (attrs) {
    this.pos = attrs.pos;
    this.vel = attrs.vel;
    this.radius = attrs.radius;
    this.color = attrs.color;
    this.game = attrs.game;
  };

  MovingObject.prototype.draw = function (ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI
    );

    ctx.fill();
  };

  MovingObject.prototype.move = function () {
    this.pos = this.game.wrap([this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]]);
  };

  MovingObject.prototype.isCollidedWith = function (otherObject) {
    var distance = Asteroids.Util.distance(this.pos, otherObject.pos);
    var radiiSum = this.radius + otherObject.radius;

    return (distance < radiiSum);
  };

  MovingObject.prototype.collideWith = function (otherObject) {
    // this.game.remove(this);
    // this.game.remove(otherObject);
  };
})();
