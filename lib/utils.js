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

})();
