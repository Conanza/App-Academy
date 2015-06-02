Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $ul = this.$pokeDetail.find("div ul.toys");

  for (attr in toy.attributes) {
    var $div = $("<div>")
    // if (attr === "name" || attr === "happiness" || attr === "price") {
    if (attr === "name") {
      var $li = $("<li>");
      var $data_toy_id = toy.id;
      var $data_poke_id = toy.get("pokemon_id");

      $li.data("toy-id", $data_toy_id);
      $li.data("poke-id", $data_poke_id);
      $li.text("toy" + attr + ": " + toy.get(attr))
    }

    $ul.append($li);
  }
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $div = $("<div class='detail'>");
  var name = toy.escape("name")
  var nameTag = $("<h3>Toy Name: " + name + "</h3>")
  var img = toy.escape("image_url");
  var imgTag = $("<img src='" + img + "'>");
  $div.append(nameTag);
  $div.append(imgTag);

  var $selectBox = $("<select data-pokemon-id data-toy-id>");
  $selectBox.data("pokemon-id", toy.get("pokemon_id"));
  $selectBox.data("toy-id", toy.id);

  this.pokes.forEach(function(pokemon) {
    if (pokemon.id === toy.get("pokemon_id")) {
      var $optionTag = $("<option selected>");
    } else {
      var $optionTag = $("<option>");
    }

    $optionTag.attr("value", pokemon.id);
    $optionTag.text(pokemon.get("name"));

    $selectBox.append($optionTag);
  })

  this.$toyDetail.html($div);
  this.$toyDetail.append($selectBox);

  this.$toyDetail.find("select").on("change", this.reassignToy.bind(this));

};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $toy = $(event.target);
  var $pokeId = $toy.data("poke-id");
  var $toyId = $toy.data("toy-id");

  var $pokemon = this.pokes.findWhere({id: $pokeId});
  var $theToy = $pokemon.toys().findWhere({id: $toyId});

  this.renderToyDetail($theToy);
};
