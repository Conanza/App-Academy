TrelloClone.Views.BoardListItem = Backbone.CompositeView.extend({
  template: JST["board/list_item"],

  tagName: "li",

  className: "list-item col-xs-3",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);

    return this;
  }
});
