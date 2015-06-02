Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail"
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex(this.pokemonDetail.bind(this, id));
    } else {
      var collection = this._pokemonIndex.collection;
      var poke = collection.get(id);
      this.detailView = new Pokedex.Views.PokemonDetail({
        model: poke,
      });
        this.detailView.refreshPokemon();

      this._swapView(this.detailView);

      $("#pokedex .pokemon-detail").html(this.detailView.$el);
    }
  },

  pokemonIndex: function (callback) {
    var $el = $("#pokedex .pokemon-list");
    var pokes = new Pokedex.Collections.Pokemon();
    var pokemonIndexView = new Pokedex.Views.PokemonIndex({
      collection: pokes,
      el: $el
    });

    this._pokemonIndex = pokemonIndexView.render();
    pokes.fetch({
      success: function () {
        callback();
      }
    });
  },

  toyDetail: function (pokemonId, toyId) {
  },

  pokemonForm: function () {
  },

  _swapView: function (newView) {
    if (this._currentView) {
      this._currentView.remove();
    }

    this._currentView = newView;
    newView.render();
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();

});
