NewsReader.Views.FeedIndex = Backbone.CompositeView.extend({
  template: JST["api/feeds/index"],

  initialize: function () {
    this.listenTo(this.collection, "destroy", this.removeIndexItem.bind(this));
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addIndexItem.bind(this));
    this.collection.each(this.addIndexItem.bind(this));
  },

  addIndexItem: function (model) {
    var view = new NewsReader.Views.IndexItem({ model: model });
    this.addSubview(".index-list", view);
  },

  removeIndexItem: function (model) {
    this.removeModelSubview(".index-list", model);
  },

  render: function () {
    var content = this.template({ feeds: this.collection });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
