Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addPokemonToList);
  },

  addPokemonToList: function (pokemon) {
    this.$el.append(JST["pokemonListItem"]({pokemon: pokemon}));
  },

  refreshPokemon: function (options, callback) {
    var that = this;
    this.collection.fetch( {
      success: function () {
        that.render();
        callback();
      }
    }); // do a empty & add to list callback on success?
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function(pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
    return this;
  },

  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).data("id");

    Backbone.history.navigate("pokemon/" + id, { trigger: true });
    // var poke = this.collection.get(id);
    // this.detailView && this.detailView.remove();
    // this.detailView = new Pokedex.Views.PokemonDetail({
    //   model: poke,
    // });
    // $("#pokedex .pokemon-detail").html(this.detailView.render().$el)
    // this.detailView.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var that = this;
    this.model.fetch({
      success: function () {
        that.render();
      }
    });
  },

  render: function () {
    this.$el.html(JST["pokemonDetail"]({ pokemon: this.model }));
    var $toys = $('<ul class="toys"></ul>');
    this.$el.append($toys);

    this.model.toys().each(function (toy) {
      $toys.append(JST["toyListItem"]({ toy: toy }));
    });
    return this;
  },

  selectToyFromList: function (event) {
    var toy = this.model.toys().get($(event.currentTarget).data("id"))

    this.toyDetailView && this.toyDetailView.remove();
    this.toyDetailView = new Pokedex.Views.ToyDetail({
      model: toy
    });

    $("#pokedex .toy-detail").html(this.toyDetailView.render().$el)
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.html(JST["toyDetail"]({ toy: this.model, pokes: new Pokedex.Collections.Pokemon() }));
    return this;
  }
});
