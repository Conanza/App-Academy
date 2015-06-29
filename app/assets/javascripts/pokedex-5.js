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
        callback && callback();
      }
    });
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
    return this;
  },

  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).data("id");

    Backbone.history.navigate("pokemon/" + id, { trigger: true });
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList",
  },

  initialize: function () {
    this.listenTo(this.model.toys(), "remove", this.render);
  },

  refreshPokemon: function (options, callback) {
    var that = this;
    this.model.fetch({
      success: function () {
        that.render();
        callback && callback();
      }
    });
  },

  render: function () {
    this.$el.html(JST["pokemonDetail"]({ pokemon: this.model }));
    var $toys = $('<ul class="toys"></ul>'); // TA: put this in template
    this.$el.append($toys);

    this.model.toys().each(function (toy) {
      this.$('.toys').append(JST["toyListItem"]({ toy: toy }));
    });
    return this;
  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data("id");
    var toy = this.model.toys().get(toyId);

    Backbone.history.navigate(
      "pokemon/" + toy.get("pokemon_id") + "/toys/" + toy.id,
       { trigger: true }
    );
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  events: {
    "change select": "reAssignToy"
  },

  render: function () {
    this.$el.html(JST["toyDetail"]({ toy: this.model, pokes: this.collection }));
    return this;
  },

  reAssignToy: function (event) {
    var $currentTarget = $(event.currentTarget);

    var pokemon = this.collection.get($currentTarget.data("pokemon-id"));
    var toy = pokemon.toys().get($currentTarget.data("toy-id"));

    toy.set("pokemon_id", $currentTarget.val());
    toy.save({}, {
      success: (function () {
        pokemon.toys().remove(toy);
        Backbone.history.navigate("pokemon/" + pokemon.id, { trigger: true });
      }).bind(this)
    });
  }
});
