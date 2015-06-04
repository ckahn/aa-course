Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    // removed add...
    this.listenTo(this.collection, "sync", this.render);
  },

  addPokemonToList: function (pokemon) {
    this.$el.append(JST["pokemonListItem"]({ pokemon: pokemon }));
  },

  refreshPokemon: function (options) {
    this.collection.fetch();
  },

  render: function () {
    this.$el.empty();
    this.collection.models.forEach(function(pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.currentTarget);
    var pokeId = $target.data('id');
    var pokemon = this.collection.get(pokeId);
    var pokemonDetail = new Pokedex.Views.PokemonDetail({
      model: pokemon,
      collection: this.collection
    });

    $("#pokedex .pokemon-detail").html(pokemonDetail.render().$el);
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toy-list-item": "selectToyFromList"
  },

  refreshPokemon: function (options) {
  },

  render: function () {
    var pokemonContent = JST['pokemonDetail']({ pokemon: this.model });
    var toysContent = $('<ul>');
    var that = this;

    this.model.fetch({
      success: function() {
        that.model.toys().forEach(function(toy) {
          toysContent.append(JST['toyListItem']({ toy: toy }));
        });
      }
    });

    this.$el.append(pokemonContent);
    this.$el.append(toysContent);

    return this;
  },

  selectToyFromList: function (event) {
    var pokeId = $(event.currentTarget).data('pokemon-id');
    var owner = this.collection.get(pokeId);
    var toyId =  $(event.currentTarget).data('id');
    var toy = owner.toys().where({id: toyId})[0];
    var toyContent = new Pokedex.Views.ToyDetail({
      model: toy,
      collection: this.collection
    });
    $("#pokedex .toy-detail").append(toyContent.render().$el);
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.html(JST['toyDetail']({ toy: this.model, pokes: this.collection }));

    return this;
  }

});

// $(function () {
//   var pokemon = new Pokedex.Collections.Pokemon();
//   var pokemonIndex = new Pokedex.Views.PokemonIndex({
//     collection: pokemon
//   });
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
