(function () {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  Asteroids.Util = {};

  Asteroids.Util.inherits = function(ChildClass, ParentClass) {
    function Surrogate() {};
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
  };

})();
