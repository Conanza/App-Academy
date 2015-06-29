$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data("content-tabs"));
  this.$activeTab = this.$contentTabs.find('.tab-pane.active');
  this.$el.on('click', 'a', this.clickTab.bind(this));
};



$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$el.find('li a').removeClass("active");
  this.$activeTab.removeClass("active");

  $(event.currentTarget).addClass("active");
  this.$activeTab.addClass("transitioning");
  this.$activeTab.one("transitionend", this.activeTab.bind(this));
};

$.Tabs.prototype.activeTab = function (event) {
  $(event.currentTarget).removeClass("transitioning");
  var id = $(this.$el).find(".active").attr("href");
  this.$activeTab = this.$contentTabs.find("" + id).addClass('active transitioning');
  setTimeout((function () {
    this.$activeTab.removeClass("transitioning");
  }).bind(this), 0);
};



$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
