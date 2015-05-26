(function () {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroid = Asteroids.Asteroid = function (pos, game) {
    var options = {};
    options.game = game;
    options.pos = pos;
    options.color = Asteroid.COLOR;
    options.radius = Asteroid.RADIUS;
    options.vel = [Math.random() * 10, Math.random() * 10];
    Asteroids.MovingObject.call(this, options);
  };

  Asteroid.COLOR = "#00FF00";
  Asteroid.RADIUS = 10;

  Asteroids.Util.inherits(Asteroids.Asteroid, Asteroids.MovingObject);

  Asteroids.Asteroid.prototype.collideWith = function(otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
      this.game.remove(this);
    }
  };
})();
