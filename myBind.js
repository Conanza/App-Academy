Function.prototype.myBind = function(object) {
  var fn = this;

  return function () {
    return fn.apply(object);
  };
};

function Superhero(name, power) {
  this.name = name;
  this.power = power;
  this.fightCrime = function() {
    console.log("I, " + this.name + ", am using " + this.power + " to fight crime!");
  };
}

var batman = new Superhero("batman", "cunning");


batman.fightCrime();

var fightCrime = batman.fightCrime;

fightCrime.myBind(batman)();

var superdude = new Superhero("phil", "flatulence");

fightCrime.myBind(superdude)();
