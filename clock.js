function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  var time = this.currentTime;
  console.log([
    time.getHours(),
    time.getMinutes(),
    time.getSeconds()
  ].join(":"));
};

Clock.prototype.run = function () {
  this.currentTime = new Date();
  this.printTime();
  setInterval(this._tick.bind(this), Clock.TICK );
};

Clock.prototype._tick = function () {
  var time = this.currentTime;
  time.setTime(time.getTime() + Clock.TICK);
  this.printTime();
};

var clock = new Clock();
clock.run();
