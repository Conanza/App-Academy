(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  Asteroids.Util = function () {};

  Asteroids.Util.inherits = function (ChildClass, ParentClass) {
    function Surrogate () {}
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
  };

  Asteroids.Util.randomVec = function (size) {
    var dx = (Math.random() * 2) - 1;
    var dy = (Math.random() * 2) - 1;

    dx = dx * (100 / size);
    dy = dy * (100 / size);

    return [dx, dy];
  };

  Asteroids.Util.distance = function (pos1, pos2) {
    return Math.sqrt(Math.pow((pos1[0] - pos2[0]), 2) +
                     Math.pow((pos1[1] - pos2[1]), 2));
  };
})();
