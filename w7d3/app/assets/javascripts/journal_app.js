window.JournalApp = {

  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new JournalApp.Routers.Posts({ $rootEl: $(".main") });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
