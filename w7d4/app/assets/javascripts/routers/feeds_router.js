NewsReader.Routers.Feeds = Backbone.Router.extend({
  routes: {
    "": "index",
    "feeds/:id(/)": "show"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  index: function () {
    var indexView = new NewsReader.Views.FeedsIndex({
      collection: NewsReader.feeds
    });
    this._swapView(indexView);
  },

  show: function (id) {
    var feed = NewsReader.feeds.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({ model: feed });
    this._swapView(showView);
  },

  _swapView: function (view) {
    this.currentView && this.currentView.remove();
    this.currentView = view;
    this.$rootEl.html(this.currentView.render().$el);
  }
});
