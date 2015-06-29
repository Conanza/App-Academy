NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "root",
    "feeds/:id": "feedShow"
  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  root: function () {
    this._currentView && this._currentView.remove();
    this._currentView = null;
  },

  feedShow: function (id) {
    var feed = NewsReader.feeds.getOrFetch(id);
    var feedShow = new NewsReader.Views.FeedShow({ model: feed });
    this._swapView(feedShow);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
