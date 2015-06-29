Function.prototype.inherits = function (superClass) {
  function Surrogate () {};
  Surrogate.prototype = superClass.prototype;
  this.prototype = new Surrogate();
};

function MovingObject () {
}


//tests
// MovingObject.prototype.moves = function () {
//   console.log("I am a moving object");
// };
//
// function Ship () {
// };
// Ship.inherits(MovingObject);
//
// Ship.prototype.we = function () {
//   console.log("im on a ship");
// };
//
// function Asteroid () {};
// Asteroid.inherits(MovingObject);
//
// Asteroid.prototype.me = function () {
//   console.log("im on an asteroid");
// };
//
// var moving = new MovingObject();
// moving.moves();
//
// var something = new Asteroid ();
// something.me();
// Asteroid.prototype.moves = function () {
//   console.log("changing moves")
// };
// something.moves();
//
// var somethingElse = new Ship();
// somethingElse.we();
// somethingElse.moves();
