TrelloClone.Views.BoardIndex = Backbone.CompositeView.extend({
  template: JST["board/index"],

  initialize: function (options) {
    this.listenTo(this.collection, "sync remove", this.render);
    this.listenTo(this.collection, "add", this.addIndexItem);
    this.listenTo(this.collection, "remove", this.removeIndexItem);

    this.collection.each(this.addIndexItem.bind(this));
  },

  addIndexItem: function (board) {
    var indexItem = new TrelloClone.Views.BoardIndexItem({ model: board });
    this.addSubview(".index-items", indexItem);
  },

  removeIndexItem: function (board) {
    this.removeModelSubview(".index-items", board);
  },

  render: function () {
    var content = this.template({ boards: this.collection });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
