Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:pokemonId/toys/:toyId": "toyDetail",
    "pokemon/:id": "pokemonDetail"
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
    } else {
      var collection = this._pokemonIndex.collection;
      var poke = collection.get(id);
      this._detailView && this._detailView.remove();
      this._detailView = new Pokedex.Views.PokemonDetail({
        model: poke,
      });
      this._detailView.refreshPokemon({}, callback);

      $("#pokedex .pokemon-detail").html(this._detailView.$el);
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
        callback && callback();
      }
    });
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if (!this._detailView) {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
    } else {
      var poke = this._detailView.model;
      var toy = poke.toys().get(toyId);

      this._toyDetailView && this._toyDetailView.remove();
      this._toyDetailView = new Pokedex.Views.ToyDetail({
        model: toy
      });

      $("#pokedex .toy-detail").html(this._toyDetailView.render().$el);
    }
  },

  pokemonForm: function () {
    this._pokemonForm = new Pokedex.Views.PokemonForm({
      model: new Pokedex.Models.Pokemon(),
      collection: this._pokemonIndex.collection
    });

    $("#pokedex .pokemon-form").html(this._pokemonForm.render().$el);
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
