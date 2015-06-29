TrelloClone.Routers.TrelloRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
  },

  routes: {
    "": "index",
    "api/boards/new": "boardNew",
    "api/boards/:id": "boardShow"
  },

  index: function () {
    this.collection.fetch();

    var indexView = new TrelloClone.Views.BoardIndex({
      collection: this.collection
    });

    this._swapView(indexView);
  },

  boardNew: function () {
    var newBoard = new TrelloClone.Models.Board();
    var newBoardView = new TrelloClone.Views.BoardNew({
      model: newBoard,
      collection: this.collection
    });

    this._swapView(newBoardView);
  },

  boardShow: function (id) {
    var board = this.collection.getOrFetch(id);
    var boardView = new TrelloClone.Views.BoardShow({ model: board });

    this._swapView(boardView);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
