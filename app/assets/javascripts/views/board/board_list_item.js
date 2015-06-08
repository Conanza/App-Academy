TrelloClone.Views.BoardListItem = Backbone.CompositeView.extend({
  template: JST["board/list_item"],

  tagName: "li",

  className: "list-item col-xs-3",

  initialize: function () {
    this.collection = this.model.cards();

    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.collection, "add", this.addCardItem);

    this.collection.each(this.addCardItem.bind(this));
  },

  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    this.attachSubviews();

    return this;
  },

  addCardItem: function (card) {
    var cardItemView = new TrelloClone.Views.CardItem({
      model: card
    });

    this.addSubview(".cards-list", cardItemView);
  }
});
