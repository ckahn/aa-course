Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $detail = JST['pokemonDetail']({ pokemon: pokemon });
  debugger;
  this.$pokeDetail.html($detail);

  // Phase 2C.
  this.$pokeDetail.append(
    '<span style="font-weight: bold;">Toys:</span><br>'
  );
  var $toys = $('<ul class="toys"></ul>');
  this.$pokeDetail.append($toys);

  pokemon.fetch({
    success: (function() {
      this.renderToysList(pokemon.toys());
    }).bind(this)
  });
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var $target = $(event.currentTarget);
  var pokeId = $target.data('id');
  Backbone.history.navigate("pokemon/" + pokeId, { trigger: true });
  //
  // this.$toyDetail.empty();
  //
  // // Phase IB
  // var $target = $(event.currentTarget);
  //
  // var pokeId = $target.data('id');
  // var pokemon = this.pokes.get(pokeId);
  //
  // this.renderPokemonDetail(pokemon);
};
