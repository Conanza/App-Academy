$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$feed = $(this.$el.data('tweets-ul'));
  this.$mentionedUsers = this.$el.find(".mentioned-users");

  this.$el.on("submit", this.submit.bind(this));
  $('textarea', this.$el).on("input", this.charCount.bind(this));
  $("a.add-mentioned-user", this.$el).on("click", this.addMentionedUser.bind(this));
  this.$mentionedUsers.on("click", "a.remove-mentioned-user", this.removedMentionedUser.bind(this));
};

$.TweetCompose.prototype.addMentionedUser = function (event) {
  var $script = this.$el.find("script");

  this.$mentionedUsers.append($script.html());
};

$.TweetCompose.prototype.removedMentionedUser = function (event) {
  $(event.currentTarget).parent().remove();
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();

  var formData = this.$el.serializeJSON();
  $(":input", this.$el).prop("disabled", true);

  $.ajax({
    url: "/tweets",
    type: "POST",
    data: formData,
    dataType: "json",
    success: this.handleSuccess.bind(this)
  });
};

$.TweetCompose.prototype.charCount = function (event) {
  var charCount = 140 - $('textarea', this.$el).val().length;

  $('.chars-left', this.$el).text(charCount + " character(s) left");
};


$.TweetCompose.prototype.handleSuccess = function (response) {
  var tweet = $('<li>').text(JSON.stringify(response));
  this.$feed.prepend(tweet);

  this.clearInput();

};

$.TweetCompose.prototype.clearInput = function (event) {
  $('.clearable', this.$el).val("");
  this.$mentionedUsers.empty();
  $(".chars-left", this.$el).empty();
  $(":input", this.$el).prop("disabled", false);
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $("form.tweet-compose").tweetCompose();
});
