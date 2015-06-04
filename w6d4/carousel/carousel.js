(function( $ ) {

  $.Carousel = function (el) {
    this.$el = $(el);
    this.activeIdx = 1;
    // $("div.items img").eq(this.activeIdx).addClass("active");
    this.bindClickHandlers(this.$el);
    this.activeImg = $("img").eq(this.activeIdx);
  };

  $.Carousel.prototype.bindClickHandlers = function ($el) {
    $el.on("click", "button.slide-left", function (event) {
      event.preventDefault();
      console.log('left');
      this.slideLeft(event);
    }.bind(this));

    $el.on("click", "button.slide-right", function (event) {
      event.preventDefault();
      this.slideRight(event);
    }.bind(this));
  };

  // clicking Next
  $.Carousel.prototype.slideLeft = function (event) {
    $("img").eq(this.slide(-1)).toggleClass("left right");
    $("img").eq(this.slide(0)).toggleClass("left");
    $("img").eq(this.slide(1)).toggleClass("right active");
    this.activeIdx = this.slide(1);
    this.activeImg = $("img").eq(this.activeIdx);
    $(this.activeImg).one("transitionend", function (event) {
      console.log("transition end");
      $("img").eq(this.slide(0)).toggleClass("active");
    }.bind(this));
  };

  // clicking Prev
  $.Carousel.prototype.slideRight = function (event) {
    $("img").eq(this.slide(-1)).toggleClass("active left");
    $("img").eq(this.slide(0)).toggleClass("active right");
    $("img").eq(this.slide(1)).toggleClass("right left");
    this.activeIdx = this.slide(-1);
  };

  $.Carousel.prototype.slide = function (dir) {
    if (dir == 0) {
      return this.activeIdx;
    } else if (dir === 1) {
      return (this.activeIdx + 1) % ($("img").length);
    } else {
      if (this.activeIdx > 0) {
        return this.activeIdx - 1;
      } else {
        return this.activeIdx + $("img").length - 1;
      }
    }
  };

  // $.Carousel.prototype.slide = function (event) {
  //   $("img").eq(this.activeIdx).toggleClass("active right");
  //   $("img").eq((this.activeIdx + 1) % ($("img").length)).toggleClass("active");
  //   var dir = '';
  //
  //   if (event.target.classList[0] === "slide-right") {
  //     this.activeIdx = (this.activeIdx + 1) % ($("img").length);
  //     dir = "right";
  //   } else {
  //     this.activeIdx += (this.activeIdx <= 0 ? $("img").length - 1: -1);
  //     dir = "left";
  //   }
  //
  //   // this.$activeImg = $("img").eq(this.activeIdx)
  //   //                           .addClass("active")
  //   //                           .addClass(dir);
  //
  //   setTimeout(function() {
  //     console.log(dir);
  //     this.$activeImg.removeClass(dir);
  //   }.bind(this), 0);
  //
  //   // this.$activeImg.one("transitionend", function() {
  //   //     console.log(this.$activeImg);
  //   //
  //   // }.bind(this));
  // };

  $.fn.carousel = function () {
    return this.each(function () {
      new $.Carousel(this);
    });
  };
}( jQuery ));
