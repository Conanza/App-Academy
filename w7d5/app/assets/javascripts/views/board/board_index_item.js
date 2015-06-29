TrelloClone.Views.BoardIndexItem = Backbone.CompositeView.extend({
  template: JST["board/index_item"],

  tagName: "div",

  events: {
    "click .delete-board": "deleteBoard",
    "click div": "showBoard",
    "mouseover div": "hover",
    "mouseout div": "removeHover"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);

    return this;
  },

  deleteBoard: function (event) {
    event.stopPropagation();
    this.model.destroy();
  },

  showBoard: function (event) {
    var link = "#/api/boards/" + this.model.id;
    Backbone.history.navigate(link, { trigger: true });
  },

  hover: function (event) {
    this.$(".board").addClass("hover");
  },

  removeHover: function (event) {
    this.$(".board").removeClass("hover");
  }
});
