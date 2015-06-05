window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.$rootEl = $("#content");

    NewsReader.feeds = new NewsReader.Collections.Feeds();
    NewsReader.feeds.fetch({ reset: true });

    var router = new NewsReader.Routers.Feeds({
      $rootEl: this.$rootEl
    });

    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
