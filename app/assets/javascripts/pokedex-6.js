Pokedex.Router = Backbone.Router.extend({
  routes: {
    "*actions": "crazyRoute",
  },

  initialize: function () {
  },

  crazyRoute: function (path) {
    var url = path;
    var matches = url.match(/#?(\w+)*\/*(\d+)*\/*(\w+)*\/*(\d+)*/);
    if (matches) {
      matches = matches.slice(1).filter(function (x) { return !!x; });
    } else {
      matches = [];
    }

    if (matches.length <= 1) {
      this.pokemonIndex();
    } else if (matches.length === 2) {
      this.pokemonIndex(this.pokemonDetail.bind(this, matches[1]));
    } else if (matches.length === 4) {

      this.pokemonIndex(this.pokemonDetail.bind(this, matches[1],
          this.toyDetail.bind(this, matches[1], matches[3])));
    } else {
      this.pokemonIndex();
    }

  },

  pokemonDetail: function (id, callback) {
    var collection = this._pokemonIndex.collection;
    var poke = collection.get(parseInt(id));
    this._detailView && this._detailView.remove();
    this._toyDetailView && this._toyDetailView.remove();
    this._detailView = new Pokedex.Views.PokemonDetail({
      model: poke
    });

    this._detailView.refreshPokemon({}, callback);

    $("#pokedex .pokemon-detail").html(this._detailView.$el);
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
      success: function () { callback && callback(); }
    });
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    var poke = this._detailView.model;
    var toy = poke.toys().get(parseInt(toyId));
    this._toyDetailView && this._toyDetailView.remove();
    this._toyDetailView = new Pokedex.Views.ToyDetail({
      model: toy,
      collection: this._pokemonIndex.collection
    });

    $("#pokedex .toy-detail").html(this._toyDetailView.render().$el);
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
