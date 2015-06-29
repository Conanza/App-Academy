Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon(attrs);
  var pokedex = this;

  pokemon.save({}, {
    success: function () {
      pokedex.pokes.add(pokemon);
      pokedex.addPokemonToList(pokemon);
      callback(pokemon);
    },

    error: function () {
      alert("bad pokemon!");
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();

  var formData = $(event.currentTarget).serializeJSON();
  this.createPokemon(formData.pokemon, this.renderPokemonDetail.bind(this));
};
