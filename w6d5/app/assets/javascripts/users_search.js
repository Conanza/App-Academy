$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$ul = this.$el.find(".users");

  this.$input.on("input", this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  var val = this.$input.val();

  $.ajax({
    type: "GET",
    data: { query: val },
    dataType: "json",
    url: "/users/search",
    success: this.renderResults.bind(this)
  });
};

$.UsersSearch.prototype.renderResults = function (response) {
  this.$ul.empty();

  for (var i = 0; i < response.length; i++) {
    var user = response[i];

    var anchor = $('<a>').attr('href', '/users/' + user.id).text(user.username);

    var button = $("<button>")
    button.followToggle({
      userId: user.id,
      followState: user.followed ? "followed" : "unfollowed"
    });

    this.$ul.append( $('<li>').append(anchor).append(button) );
  }
};

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $("div.users-search").usersSearch();
});
