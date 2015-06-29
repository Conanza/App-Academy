Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $div = $("<div class='detail'>");
  var $img = $("<img  src='" + pokemon.get("image_url") + "'>");
  $div.append($img);
  var that = this;

  for (attr in pokemon.attributes) {
    if (attr === "created_at" || attr === "updated_at" ||
                                 attr === "id" || attr === "image_url") {
    } else {
      var $li = $("<li>");
      $li.text(attr + ": " + pokemon.escape(attr));
      $div.append($li);
    }
  }

  $div.append( $("<ul class='toys'>") );
  pokemon.fetch({
    success: function (resp) {
      pokemon.toys().each(function(toy) {
        that.addToyToList(toy);
      })

      that.renderToysList(pokemon.toys());
    }
  });

  this.$pokeDetail.html($div);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var $id = $(event.target).data('id');
  var $pokemon = this.pokes.findWhere({id: $id});
  this.renderPokemonDetail($pokemon);
};
