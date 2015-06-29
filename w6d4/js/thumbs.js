$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$activeImg = this.$el.find(".gutter-images img").eq(0)
  this.activate(this.$activeImg);

  this.$el.find(".gutter-images")
  .on('click', 'img', function() {
    this.activate($(event.target));
    this.$activeImg = this.$el.find(".active img");

    }.bind(this));

  this.$el.find(".gutter-images")
    .on("mouseenter", "img", function () {
      this.activate($(event.target))}.bind(this));

  this.$el.find(".gutter-images")
    .on("mouseleave", "img", function () {
      this.activate($(this.$activeImg));
      }.bind(this));

};

$.Thumbnails.prototype.activate = function ($img) {



  var $clonedImg = $img.clone()
  var activeDiv = this.$el.find(".active");
  activeDiv.find("img").remove();
  activeDiv.append($clonedImg);
};

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
