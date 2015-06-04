JournalApp.Views.PostForm = Backbone.View.extend({

  initialize: function(options){
    this.errors = options.errors;
    this.listenTo(this.model, "sync", this.render);
  },

  template: JST["posts/post_form"],

  render: function(){
    var content = this.template({ post: this.model, errors: this.errors });
    this.$el.html(content);
    return this;
  },

  events: {
    "submit form": "submitForm"
  },

  submitForm: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON()["post"];
    var that = this;
    this.model.save(formData, {
      success: function () {
        that.collection.add(that.model);
        Backbone.history.navigate("posts/" + that.model.id, { trigger: true });
      },

      error: function (model, response) {
        var errors = response.responseJSON;
        var newForm = new JournalApp.Views.PostForm({model: that.model, errors: errors, collection: that.collection});

        that.$el.html(newForm.render().$el);
      }
    });
  }

});
