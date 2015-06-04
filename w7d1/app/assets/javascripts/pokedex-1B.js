Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  this.$pokeDetail.empty();

  var $details =
    $("<div>").addClass("detail")
              .append("<img src=" + pokemon.escape("image_url") + ">")

  var $attrs = $("<div>")
    .append("<p><strong>Name</strong>: " + pokemon.get("name"))
    .append("<p><strong>Attack</strong>: " + pokemon.get("attack"))
    .append("<p><strong>Defense</strong>: " + pokemon.get("defense"))
    .append("<p><strong>Poke Type</strong>: " + pokemon.get("poke_type"))
    .append(
      "<p><strong>Moves</strong>: " +
      pokemon.get("moves").toString().replace(/,/g, ', ')
    );

  $details.append($attrs);

  this.$pokeDetail.append($details);

  this.$pokeDetail.append("<ul class=pokemon-list>");

  var rootView = this;
  pokemon.fetch({
    success: function () {
      pokemon.toys().each(function (toy) {
        Pokedex.RootView.prototype.addToyToList(toy);
      })
    }
  });
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var pokemonId = $(event.currentTarget).data("id");
  this.renderPokemonDetail(this.pokes.get(pokemonId));
};
