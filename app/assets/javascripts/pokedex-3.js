Pokedex.RootView.prototype.reassignToy = function (event) {
  var oldPokeId = $(event.currentTarget).data("pokemon-id");
  var toyId = $(event.currentTarget).data("toy-id");

  var $oldPokemon = this.pokes.findWhere({id: oldPokeId});
  var $toy = $oldPokemon.toys().findWhere({id: toyId});

  var newPokeId = parseInt($(event.currentTarget).val());
  $toy.set({ pokemon_id: newPokeId });

  var that = this;

  $toy.save({}, {
    success: function(resp) {
      $oldPokemon.toys().remove($toy);
      // that.renderPokemonDetail($oldPokemon);
      that.renderToysList($oldPokemon.toys());
      that.$toyDetail.empty();
    }
  });
};

Pokedex.RootView.prototype.renderToysList = function (toys) {
  this.$pokeDetail.find(".toys").empty();
  toys.forEach(function(toy) {
    this.addToyToList(toy);
  }.bind(this))
};
