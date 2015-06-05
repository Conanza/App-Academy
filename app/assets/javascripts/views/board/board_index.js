TrelloClone.Views.BoardIndex = Backbone.CompositeView.extend({
  template: JST["board/index"],

  initialize: function (options) {
    this.listenTo(this.collection, "sync add", this.render);
    this.listenTo(this.collection, "add", this.addIndexItem);

    this.collection.each(this.addIndexItem.bind(this));
  },

  addIndexItem: function (board) {
    var indexItem = new TrelloClone.Views.BoardIndexItem({ model: board });
    this.addSubview(".index-items", indexItem);
  },

  render: function () {
    var content = this.template({ boards: this.collection });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
