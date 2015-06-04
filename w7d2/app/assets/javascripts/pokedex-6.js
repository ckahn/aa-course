Pokedex.Router = Backbone.Router.extend({
  initialize: function () {
  },

  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'pokemonDetail'
  },

  pokemonDetail: function (id, callback) {
    var pokemon = new Pokedex.Models.Pokemon({id: id});
    debugger;
    pokemon.fetch({
      success: function (resp) {

      }
    });
    // var $detail = JST['pokemonDetail']({ pokemon: pokemon });
    // this.$pokeDetail.html($detail);
    //
    // // Phase 2C.
    // this.$pokeDetail.append(
    //   '<span style="font-weight: bold;">Toys:</span><br>'
    // );
    // var $toys = $('<ul class="toys"></ul>');
    // this.$pokeDetail.append($toys);
    //
    // pokemon.fetch({
    //   success: (function() {
    //     this.renderToysList(pokemon.toys());
    //   }).bind(this)
    // });
  },

  pokemonIndex: function (callback) {
    $(function () {
      var pokemon = new Pokedex.Collections.Pokemon();
      var pokemonIndex = new Pokedex.Views.PokemonIndex({
        collection: pokemon
      });
      pokemonIndex.refreshPokemon();
      $("#pokedex .pokemon-list").html(pokemonIndex.$el);
    });
  },

  toyDetail: function (pokemonId, toyId) {
  },

  pokemonForm: function () {
  }
});

$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
