$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data('user-id') || options.userId;
  this.followState = this.$el.data('initial-follow-state') || options.followState;

  this.render();
  this.$el.on("click", this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  var buttonText = (this.followState === "followed") ? "Unfollow!!" : "Follow!!";

  if (this.followState === "following") {
    this.$el.prop("disabled", true);
    this.$el.html("following...");
  } else if (this.followState === "unfollowing") {
    this.$el.prop("disabled", true);
    this.$el.html("unfollowing...");
  } else if (this.followState === "followed") {
    this.$el.prop("disabled", false);
    this.$el.html(buttonText);
  } else if (this.followState === "unfollowed") {
    this.$el.prop("disabled", false);
    this.$el.html(buttonText);
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();

  if (this.followState === "followed") {
    this.followState = "unfollowing";
    this.render();

    $.ajax({
        url: "/users/" + this.userId + "/follow",
        type: "DELETE",
        dataType: "json",
        success: (function () {
          this.followState = "unfollowed";
          this.render();
        }).bind(this)
    });
  } else if (this.followState === "unfollowed") {
    this.followState = "following";
    this.render();

    $.ajax({
        url: "/users/" + this.userId + "/follow",
        type: "POST",
        dataType: "json",
        success: (function () {
          this.followState = "followed";
          this.render();
        }).bind(this)
    });
  }

};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
