TrelloClone.Views.BoardNew = Backbone.CompositeView.extend({
  template: JST["board/form"],

  tagName: "form",

  className: "board-form",

  events: {
    "click button": "submit"
  },

  render: function () {
    var content = this.template({
      board: this.model
    });
    this.$el.html(content);

    return this;
  },

  submit: function (event) {
    event.preventDefault();

    var data = this.$el.serializeJSON()["board"];

    this.model.set(data);

    this.model.save({}, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate("", { trigger: true });
      }.bind(this),

      error: function (model, response) {
        this.$(".errors").empty();

        response.responseJSON.forEach(function (error){
          this.$(".errors").append($("<li>").text(error));
        });
      }.bind(this)
    });
  }
});
