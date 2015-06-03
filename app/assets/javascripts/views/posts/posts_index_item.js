JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  tagName: "li",

// events hash - listen for events on elements
  events: {
    "click .delete-button": "removeIndexItem"
  },

  template: JST["posts/index_item"],

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  removeIndexItem: function(event){
    event.preventDefault();
    this.model.collection.remove(this.model);
    this.model.destroy();
    this.remove();
  }
});
