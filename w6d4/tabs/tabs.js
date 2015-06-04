(function( $ ) {

  $.Tabs = function (el) {
    this.$el = $(el);
    this.$contentTabs = $(this.$el.data("data-content-tabs"));
    this.$activeLink = $(".tabs li a").eq(0).addClass('active');
    this.$activeContent = $('div.tab-pane').eq(0).addClass('active');
    this.transitioning = false;
    this.bindEventHandler(this.$el);
  };

  $.Tabs.prototype.bindEventHandler = function($el) {
    $el.on("click", "a", function(event) {
      event.preventDefault();
      if (this.transitioning === true) {
        return;
      }
      this.clickLink(event);
    }.bind(this));

  }

  $.Tabs.prototype.clickLink = function (event) {
    this.transitioning = true;
    var $oldActiveLink = this.$activeLink.removeClass("active");
    var $newActiveLink = $(event.target).addClass("active");
    this.$activeLink = $newActiveLink;
    var href = this.$activeLink.attr("href").slice(1);

    var $oldActiveContent = this.$activeContent
                                .removeClass("active")
                                .addClass("transitioning");


    $oldActiveContent.one("transitionend", function (event) {
      $oldActiveContent.removeClass("transitioning");
      this.$activeContent = $(".tab-pane[id=" + href + "]")
                            .addClass('active')
                            .addClass("transitioning");

      setTimeout(function() {
        this.$activeContent.removeClass("transitioning");
      }.bind(this), 0);

      this.transitioning = false;
    }.bind(this));
  };

  $.fn.tabs = function () {
    return this.each(function () {
      new $.Tabs(this);
    });
  };

}( jQuery ));
