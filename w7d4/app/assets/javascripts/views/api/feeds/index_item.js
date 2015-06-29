NewsReader.Views.IndexItem = Backbone.CompositeView.extend({
  template: JST["api/feeds/index_item"],
  tagName: "li",

  events: {
    "click .delete-index-item": "deleteIndexItem"
  },

  deleteIndexItem: function () {
    this.model.destroy({ wait: true });
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  }
});
