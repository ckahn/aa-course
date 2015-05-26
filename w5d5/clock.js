
function Clock () {
}

Clock.TICK = 100;

Clock.prototype.printTime = function () {
   console.log("" + currentTime.getHours() + ":" +
              currentTime.getMinutes() + ":" +
              currentTime.getSeconds() + "." +
              Math.floor((currentTime.getMilliseconds()/100)));
};

Clock.prototype.run = function () {
  currentTime = new Date();
  this.printTime();
  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  currentTime.setMilliseconds(currentTime.getMilliseconds() + Clock.TICK);
};

var clock = new Clock();
clock.run();
