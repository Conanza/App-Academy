window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    NewsReader.feeds = new NewsReader.Collections.Feeds();

    var $rootEl = $('#content');
    var router = new NewsReader.Routers.Router({ $rootEl: $rootEl });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
