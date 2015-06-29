NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST["api/feeds/show"],

  events: {
    "click .refresh": "refreshPage"
  },

  addFeedItem: function (feed) {
    var subview = new NewsReader.Views.FeedItem({ model: feed });
    this.addSubview('.feed-list', subview);
  },

  initialize: function () {
    this.listenTo(this.model, "destroy", this.removeFeedItem);
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.entries(), 'add', this.addFeedItem.bind(this));
    this.model.entries().each(this.addFeedItem.bind(this));
  },

  render: function() {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  removeFeedItem: function() {
    Backbone.history.history.back();
  },

  refreshPage: function () {
    this.model.fetch();
  }
});
