TrelloClone.Views.BoardListItem = Backbone.CompositeView.extend({
  template: JST["board/list_item"],

  tagName: "li",

  className: "list-item col-xs-3",

  events: {
    "submit form.new-card": "createCard",
    "click .delete-list-item": "deleteList",
    "mouseover .card-item div": "hover",
    "mouseout .card-item div": "removeHover"
  },

  hover: function (event) {
    $(event.currentTarget).addClass("cardHover");
    $(event.currentTarget).find("button").removeClass("hidden");
  },

  removeHover: function (event) {
    $(event.currentTarget).removeClass("cardHover");
    $(event.currentTarget).find("button").addClass("hidden");
  },

  deleteList: function (event) {
    event.preventDefault();
    this.model.destroy();
  },

  initialize: function () {
    this.collection = this.model.cards();

    this.listenTo(this.collection, "remove", this.removeCardItem);
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.collection, "add", this.addCardItem);

    this.collection.each(this.addCardItem.bind(this));
  },

  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    this.attachSubviews();

    return this;
  },

  removeCardItem: function (card) {
    this.removeModelSubview(".cards-list", card);
  },

  addCardItem: function (card) {
    var cardItemView = new TrelloClone.Views.CardItem({
      model: card
    });

    this.addSubview(".cards-list", cardItemView);
  },

  createCard: function (event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON().card;
    $(data).attr("list_id", this.model.id);
    var newCard = new TrelloClone.Models.Card(data);

    newCard.save({}, {
      success: function (model, response) {
        this.$(".clearable").val("");
        this.collection.add(model);
      }.bind(this),

      error: function (model, response) {
        alert("couldn't create card");
      }
    });
  }
});
