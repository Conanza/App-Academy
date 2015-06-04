JournalApp.Collections.Posts = Backbone.Collection.extend({
  model: JournalApp.Models.Post,

  url: "/posts",

  getOrFetch: (function (id) {
    var collection = this;
    var post = collection.get(id);

    if (post) {
      post.fetch();
    } else {
      post = new JournalApp.Models.Post({id: id});
      post.fetch({
        success: function(){
          collection.add(post);
        }
      });
    }
    return post;
  })

});
