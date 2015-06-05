NewsReader.Views.FeedItem = Backbone.CompositeView.extend({
  tagName: 'li',
  
  template: JST["api/feeds/entry"],

  initialize: function () {
    this.listenTo(this.model, "add", this.render);
  },

  render: function () {
    var content = this.template({ entry: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
