TrelloClone.Views.BoardIndexItem = Backbone.CompositeView.extend({
  template: JST["board/index_item"],

  tagName: "div",

  className: "board col-xs-3",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);

    return this;
  }
});
