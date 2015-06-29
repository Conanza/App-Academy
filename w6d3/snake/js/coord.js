(function () {
  if (typeof SnakeGame === 'undefined') {
    window.SnakeGame = {};
  }

  var Coord = SnakeGame.Coord = function () {
  };

  Coord.plus = function(thisCoord, otherCoord) {
    return [thisCoord[0] + otherCoord[0], thisCoord[1] + otherCoord[1]];
  };

  Coord.equals = function(thisCoord, otherCoord) {
    return (thisCoord[0] === otherCoord[0] && thisCoord[1] === otherCoord[1]);
  };

  Coord.isOpposite = function(thisCoord, otherCoord) {

  };

})();
