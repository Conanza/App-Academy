TrelloClone.Collections.Cards = Backbone.Collection.extend({
  url: "/api/cards",

  model: TrelloClone.Models.Card,

  initialize: function (models, options) {
    this.list = options.list;
  },

  comparator: function (card1, card2) {
    if (card1.get("ord") > card2.get("ord")) {
      return 1;
    } else {
      return -1;
    }
  },

  getOrFetch: function (id) {
    var card = this.get(id);

    if (card) {
      card.fetch();
    } else {
      card = new TrelloClone.Models.Card({ id: id });
      card.fetch({
        success: function () {
          this.add(card);
        }.bind(this)
      });
    }

    return card;
  }
});
