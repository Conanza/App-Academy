TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["board/show"],

  initialize: function () {
    this.collection = this.model.lists();

    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.collection, "add", this.addListItem);

    this.collection.each(this.addListItem.bind(this));
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    this.attachSubviews();

    return this;
  },

  addListItem: function (list) {
    var listItemView = new TrelloClone.Views.BoardListItem({
      model: list
    });

    this.addSubview(".board-lists", listItemView);
  }
});
