TrelloClone.Views.CardItem = Backbone.CompositeView.extend({
  template: JST["list/card_item"],

  tagName: "li",

  className: "card-item",

  attributes: function () {
    return {
      "data-id": this.model.id,
      "data-ord": this.model.escape("ord"),
      "data-list-id": this.model.escape("list_id")
    };
  },

  events: {
    "click .delete-card-item": "deleteCard"
  },

  deleteCard: function (event) {
    event.preventDefault();
    this.model.destroy();
  },

  render: function () {
    var content = this.template({ card: this.model });
    this.$el.html(content);

    return this;
  }
});
