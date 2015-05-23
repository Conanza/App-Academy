function Clock () {
}
var clock = new Clock();

clock.TICK = 5000;

Clock.prototype.printTime = function () {
  var time = this.time;
  console.log(time.getHours() + ':' + time.getMinutes() + ':' + time.getSeconds() );
};

Clock.prototype.run = function (tickCb) {
  this.time = new Date();
  this.printTime();
  setInterval(tickCb, this.TICK );

};

Clock.prototype._tick = function () {
  var time = this.time;
  time.setTime(time.getTime() + this.TICK);
  this.printTime();
};

clock.run(clock._tick.bind(clock));
