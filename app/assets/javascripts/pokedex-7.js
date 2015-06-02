Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form": "savePokemon"
  },

  render: function () {
    this.$el.html(JST["pokemonForm"]());

    return this;
  },

  savePokemon: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON()["pokemon"];

    var newPoke = new Pokedex.Models.Pokemon(formData);
    var that = this;
    newPoke.save({}, {
      success: function (model, response, options) {
        that.collection.add(newPoke);
        Backbone.history.navigate("pokemon/" + model.id, { trigger: true });
      }
    });
  }
});
