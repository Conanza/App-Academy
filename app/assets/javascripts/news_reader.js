window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    NewsReader.feeds = new NewsReader.Collections.Feeds();

    var $rootEl = $('#feed');
    var $index = $('#index');

    var router = new NewsReader.Routers.Router({ $rootEl: $rootEl });

    NewsReader.feeds.fetch();
    var indexView = new NewsReader.Views.FeedIndex({
      collection: NewsReader.feeds
    });
    $index.html(indexView.render().$el);

    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
