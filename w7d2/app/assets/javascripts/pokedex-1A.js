Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $detail = JST["pokemonListItem"]({pokemon: pokemon});
  this.$pokeList.append($detail);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  this.pokes.fetch({
    success: (function () {
      this.$pokeList.empty();
      this.pokes.each(this.addPokemonToList.bind(this));
    }).bind(this)
  });

  return this.pokes;
};
