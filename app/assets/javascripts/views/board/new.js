TrelloClone.Views.BoardNew = Backbone.CompositeView.extend({
  template: JST["board/form"],

  tagName: "form",

  className: "board-form",

  events: {

  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);

    return this;
  }
});
