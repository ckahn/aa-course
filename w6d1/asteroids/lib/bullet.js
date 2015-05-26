(function () {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Bullet = Asteroids.Bullet = function(pos, vel, game) {
    var options = {};
    options.game = game;
    options.pos = pos;

    options.radius = Bullet.RADIUS;
    options.color = Bullet.COLOR;
    options.vel = vel;
    Asteroids.MovingObject.call(this,options);
  };

  Bullet.RADIUS = 5;
  Bullet.COLOR = "#003399";

})();
