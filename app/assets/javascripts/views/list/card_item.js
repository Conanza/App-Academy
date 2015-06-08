TrelloClone.Views.CardItem = Backbone.CompositeView.extend({
  template: JST["list/card_item"],

  tagName: "li",

  className: "card-item",

  render: function () {
    var content = this.template({ card: this.model });
    this.$el.html(content);

    return this;
  }
});
