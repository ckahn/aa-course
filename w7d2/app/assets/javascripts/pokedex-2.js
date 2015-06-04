Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $toyListItem = JST['toyListItem']( { toy: toy } );
  this.$pokeDetail.find(".toys").append($toyListItem);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) { // III
  var $detail = JST['toyDetail']({ toy: toy, pokes: this.pokes });
  this.$toyDetail.html($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $target = $(event.target);

  var toyId = $target.data('id');
  var pokemonId = $target.data('pokemon-id');

  var pokemon = this.pokes.get(pokemonId);
  var toy = pokemon.toys().get(toyId);

  this.renderToyDetail(toy);
};
