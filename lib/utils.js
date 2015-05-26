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

    dx = dx * (70 / size);
    dy = dy * (70 / size);

    return [dx, dy];
  };

})();
