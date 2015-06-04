Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPokemon = new Pokedex.Models.Pokemon();
  newPokemon.save(attrs, {
    success: function (pokemon, response) {
      this.pokes.add(pokemon);
      this.addPokemonToList(pokemon);
      callback(pokemon);
    }.bind(this)
  })
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var newPokemon = $(event.target).serializeJSON();
  this.createPokemon(newPokemon, this.renderPokemonDetail.bind(this));
};
