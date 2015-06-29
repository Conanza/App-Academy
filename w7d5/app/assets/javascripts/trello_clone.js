window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var boards = new TrelloClone.Collections.Boards();

    var router = new TrelloClone.Routers.TrelloRouter({
      $rootEl: $("div#main"),
      collection: boards
    });

    Backbone.history.start();
  }
};
