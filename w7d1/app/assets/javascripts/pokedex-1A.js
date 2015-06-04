Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  $("<li>").addClass("poke-list-item")
           .text(pokemon.escape("name") +
             ' (' + pokemon.escape("poke_type") + ')')
           .appendTo(this.$pokeList)
           .attr("data-id", pokemon.escape("id"));
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  this.pokes.fetch({
    success: function (collection) {
      collection.each(function (pokemon) {
        Pokedex.rootView.addPokemonToList(pokemon);
      })
    }
  });
};
