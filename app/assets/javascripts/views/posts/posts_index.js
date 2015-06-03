JournalApp.Views.PostsIndex = Backbone.View.extend({

  // view, listenTo models or collections
  initialize: function () {
    this.listenTo(this.collection, "remove reset", this.render);
  },

  tagName: "ul",

  // look in templates directory
  template: JST['posts/index'],

  render: function () {
    this.$el.empty();

    this.collection.each(function(post) {
      var postView = new JournalApp.Views.PostsIndexItem({ model: post });
      this.$el.append(postView.render().$el);
    }.bind(this));

    return this;
  }

});
