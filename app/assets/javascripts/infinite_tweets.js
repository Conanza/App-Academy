$.InfiniteTweets = function (el) {
  this.$el = $(el);
  this.$feed = this.$el.find("ul#feed");
  this.maxCreatedAt = null;
  this.$fetchLink = this.$el.find(".fetch-more")

  this.$feed.on("insert-tweet", this.insertTweet.bind(this));
  this.$fetchLink.on("click", this.fetchTweets.bind(this));
};

$.InfiniteTweets.prototype.fetchTweets = function (event) {
  event.preventDefault();

  var options = {
    type: "GET",
    dataType: "json",
    url: "/feed",
    success: (function (tweets) {
      this.insertTweets(tweets);

      if (tweets.length < 20) {
        this.$fetchLink.replaceWith("<p>No more tweets left</p>");
      }

      if (tweets.length > 0) {
        this.maxCreatedAt = tweets[tweets.length - 1].created_at;
      }

    }).bind(this)
  };

  if (this.maxCreatedAt) {
    options.data = {max_created_at: this.maxCreatedAt};
  }

  $.ajax(options);
};

$.InfiniteTweets.prototype.insertTweet = function (event, tweet) {
  var feedTemplate = $("script", this.$el).html();
  var tempFn = _.template(feedTemplate);

  var content = tempFn({tweets: [tweet]});
  this.$feed.prepend(content);

  if (!this.maxCreatedAt) {
    this.maxCreatedAt = tweet.created_at;
  }
};

$.InfiniteTweets.prototype.insertTweets = function (tweets) {
  var feedTemplate = $("script", this.$el).html();
  var tempFn = _.template(feedTemplate);

  var content = tempFn({tweets: tweets});
  this.$feed.append(content);
};

$.fn.infiniteTweets = function () {
  return this.each(function () {
    new $.InfiniteTweets(this);
  });
};

$(function () {
  $("div.infinite-tweets").infiniteTweets();
});
