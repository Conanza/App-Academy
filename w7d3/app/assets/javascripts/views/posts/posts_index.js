JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/index'],

  initialize: function () {
    this.listenTo(this.collection, "remove reset", this.render);
  },

  tagName: "ul",



  render: function () {
    this.$el.empty();

    this.collection.each(function(post) {
      var postView = new JournalApp.Views.PostsIndexItem({ model: post });
      this.$el.append(postView.render().$el);
    }.bind(this));

    return this;
  }

});
