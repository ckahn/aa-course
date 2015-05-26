

Object.prototype.inherits = function(parent){
  function Surrogate() {};  
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
};

function MovingObject () {}

MovingObject.prototype.move = function(){
  console.log("Move!");
};

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);

Asteroid.prototype.fly = function(){
  console.log("flying asteroid");
};

Ship.prototype.coast = function(){
  console.log("Coasting ship.");
};

var ast = new Asteroid();
ast.move();
ast.fly();

var shp = new Ship();
shp.move();
shp.coast();

var mv = new MovingObject();
console.log(mv.__proto__);
