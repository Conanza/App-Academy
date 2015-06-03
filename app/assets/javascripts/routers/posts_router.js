JournalApp.Routers.Posts = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = new JournalApp.Collections.Posts();
  },

  routes: {
    "": "index",
    "posts/:id": "show"
  },

  index: function () {
    this.collection.fetch({reset: true});
    var postsIndexView = new JournalApp.Views.PostsIndex({
      collection: this.collection
    });
    this._swapView(postsIndexView);
  },

  show: function (id) {
    var post = this.collection.getOrFetch(id);
    var postShowView = new JournalApp.Views.PostShow({ model: post });
    this._swapView(postShowView);
  },

  _swapView: function (newView) {
    this.currentView && this.currentView.remove();
    this.currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }


});
