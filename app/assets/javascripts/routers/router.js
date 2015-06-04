NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "index",
    "feeds/:id": "feedShow"
  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  index: function() {
    NewsReader.feeds.fetch();
    var indexView = new NewsReader.Views.FeedIndex({
      collection: NewsReader.feeds
    });
    this.$rootEl.html(indexView.render().$el);
  },

  feedShow: function (id) {
    alert("feedshow" + id)
  }
});
