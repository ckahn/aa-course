(function () {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.bullets = [];
    this.addAsteroids();

    this.ship = new Asteroids.Ship([Game.DIM_X/2,Game.DIM_Y/2], this);
  };

  Game.DIM_X = 800;
  Game.DIM_Y = 600;
  Game.NUM_ASTEROIDS = 5;

  Asteroids.Game.prototype.addAsteroids = function(){
    for(var i = 0; i < Game.NUM_ASTEROIDS; i++){
      this.asteroids.push(new Asteroids.Asteroid(this.randomPosition(), this));
    }
  };

  Asteroids.Game.prototype.allObjects = function(){
    return [this.ship].concat(this.asteroids.concat(this.bullets));
  };

  Asteroids.Game.prototype.draw = function(ctx){
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    //debugger
    this.allObjects().forEach(function (asteroid) {
      asteroid.draw(ctx);
    });
  };

  Asteroids.Game.prototype.randomPosition = function(){
    var pos = [0,0];
    pos[0] = Math.random() * Game.DIM_X;
    pos[1] = Math.random() * Game.DIM_Y;
    return pos;
  };

  Asteroids.Game.prototype.moveObjects = function() {
    for(var i = 0; i < this.allObjects().length; i++){
      this.allObjects()[i].move();
    }
  };

  Asteroids.Game.prototype.wrap = function(pos){
    var wrapped = [];
    if (pos[0] < 0) {
      wrapped[0] = Game.DIM_X + pos[0];
    } else {
      wrapped[0] = pos[0] % Game.DIM_X;
    }
    if (pos[1] < 0) {
      wrapped[1] = Game.DIM_X + pos[1];
    } else {
      wrapped[1] = pos[1] % Game.DIM_X;
    }
    return wrapped;
  };

  Asteroids.Game.prototype.checkCollisions = function() {
    for (var i = this.allObjects().length - 1; i >= 1; i--) {
      for (var j = i - 1; j >= 0; j--) {
        if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])) {
          this.allObjects()[i].collideWith(this.allObjects()[j]);
        }
      }
    }
  };

  Asteroids.Game.prototype.remove = function(asteroid){
    var index = this.asteroids.indexOf(asteroid);
    this.asteroids.splice(index, 1);
  };

  Asteroids.Game.prototype.step = function() {
    this.moveObjects();
    this.checkCollisions();
  };

  Asteroids.Game.prototype.add = function(obj){
    if (obj instanceof Asteroids.Bullet){
      this.bullets.add(obj);
    }
    if (obj instanceof Asteroids.Asteroid){
      this.asteroids.add(obj);
    }
  };

})();
