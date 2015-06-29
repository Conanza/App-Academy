Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $("<li>");
  var $name = pokemon.get("name");
  var $pokeType = pokemon.get("poke_type");

  $li.text($name + ": " + $pokeType);
  $li.addClass("poke-list-item");
  $li.data("id", pokemon.id);
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var that = this;
  this.pokes.fetch({
    success: function (resp) {
      that.pokes.forEach( function(poke){
        that.addPokemonToList(poke);
      });
    }
  });
};
