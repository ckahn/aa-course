(function () {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function(game, ctx) {
    this.game = game;
    this.ctx = ctx;
  };

  Asteroids.GameView.prototype.start = function() {
    ctx = this.ctx;
    game = this.game;
    this.bindKeyHandlers();
    window.setInterval((function () {
      game.step();
      game.draw(ctx);
    }).bind(this), 1000 / 20);
  };

  Asteroids.GameView.prototype.bindKeyHandlers = function() {
    shp = this.game.ship
    key("k", function(){shp.power([0,3]);});
    key("i", function(){shp.power([0,-3]);});
    key("j", function(){shp.power([-3,0]);});
    key("l", function(){shp.power([3,0]);});
    //key("k", this.game.ship.power([0, -1]));
    //key("h", this.game.ship.power([-1, 0]));
    //key("l", this.game.ship.power([1, 0]));
  };

})();
