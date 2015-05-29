$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;

  this.$el.find('div.items li:first-child').addClass("active");
  this.$el.on("click", ".slide-right", this.slideRight.bind(this));
  this.$el.on("click", ".slide-left", this.slideLeft.bind(this));
};

$.Carousel.prototype.slide = function (dir) {
  if (this.transitioning) {
    return;
  }
  this.transitioning = true;
  if (dir < 0) {
    var property = "left";
    var outdir = "right";
  } else {
    var property = "right";
    var outdir = "left";
  }
  var activeli = this.$el.find(".items ul li").eq(this.activeIdx);
  activeli.addClass(outdir);
  activeli.one('transitionend', function() {
    this.transitioning = false
    activeli.removeClass('active right left');
  }.bind(this));


  this.activeIdx += dir;
  this.activeIdx = this.activeIdx % this.$el.find("li").length ;
  var newActiveli = this.$el.find(".items ul li").eq(this.activeIdx)
  newActiveli.addClass("active " + property);

  setTimeout(function() {
    newActiveli.removeClass(property);
    // this.$el.find('.active').removeClass('right left');
  }.bind(this), 0);

};

$.Carousel.prototype.slideRight = function() {
  this.slide(1);
};

$.Carousel.prototype.slideLeft = function() {
  this.slide(-1);
};



$.fn.carousels = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
