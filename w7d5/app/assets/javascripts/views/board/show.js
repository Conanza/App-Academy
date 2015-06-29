TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["board/show"],

  initialize: function () {
    this.collection = this.model.lists();

    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.collection, "add", this.addListItem);
    this.listenTo(this.collection, "remove", this.removeListItem);

    this.collection.each(this.addListItem.bind(this));
  },

  events: {
    "submit form.new-list": "createList",
    "mouseover li.list-item": "addHover",
    "mouseout li.list-item": "removeHover",
    "click .delete-list-item": "removeListItem"
  },

  removeListItem: function (list) {
    this.removeModelSubview(".board-lists", list);
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    this.attachSubviews();

    $(".sortable").sortable({
      connectWith: ".cards-list",

      stop: function (event, ui) {
        debugger
      },

      remove: function (event, ui) {
        console.log("removed from ")
      },

      receive: function (event, ui) {
        console.log("received at")
      }
    })

    return this;
  },

  addListItem: function (list) {
    var listItemView = new TrelloClone.Views.BoardListItem({
      model: list
    });

    this.addSubview(".board-lists", listItemView);
  },

  createList: function (event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON()["list"];
    $(data).attr("board_id", this.model.id);

    var newList = new TrelloClone.Models.List(data);

    newList.save({}, {
      success: function (model, response) {
        this.$(".new-list input.clearable").val("");
        this.collection.add(model);
      }.bind(this),

      error: function (model, response) {
        alert("cant do that");
      }
    });
  },

  addHover: function (event) {
    this.$(event.currentTarget).addClass("hover");
  },

  removeHover: function (event) {
    this.$(".list-item").removeClass("hover");
  }
});
