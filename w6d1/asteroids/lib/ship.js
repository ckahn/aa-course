(function () {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function(pos, game) {
    var options = {};
    options.game = game;
    options.pos = pos;

    options.radius = Ship.RADIUS;
    options.color = Ship.COLOR;
    options.vel = [0,0];
    Asteroids.MovingObject.call(this,options);
  };

  Ship.RADIUS = 10;
  Ship.COLOR = "#003399";

  Asteroids.Util.inherits(Asteroids.Ship, Asteroids.MovingObject);

  Asteroids.Ship.prototype.relocate = function() {
    this.pos = this.game.randomPosition();
    this.vel = [0,0];
  };

  Asteroids.Ship.prototype.power = function(impulse) {
    //debugger
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  Asteroids.Ship.prototype.fireBullet = function(){
    this.game.add(new Bullet(this.pos,this.vel, this.game));
  }

})();
