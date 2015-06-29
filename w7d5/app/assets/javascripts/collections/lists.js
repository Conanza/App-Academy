TrelloClone.Collections.Lists = Backbone.Collection.extend({
  url: "/api/lists",

  initialize: function (models, options) {
    this.board = options.board;
  },

  model: TrelloClone.Models.List,

  comparator: function (list1, list2) {
    if (list1.get("ord") > list2.get("ord")) {
      return 1;
    } else {
      return -1;
    }
  },

  getOrFetch: function (id) {
    var list = this.get(id);

    if (list) {
      list.fetch();
    } else {
      list = new TrelloClone.Models.List({ id: id });
      list.fetch({
        success: function () {
          this.add(list);
        }.bind(this)
      });
    }

    return list;
  }
});
