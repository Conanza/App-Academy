NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST["api/feeds/show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click .refresh": "refreshPage"
  },

  render: function() {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  },

  refreshPage: function () {
    this.model.fetch();
  }
});
