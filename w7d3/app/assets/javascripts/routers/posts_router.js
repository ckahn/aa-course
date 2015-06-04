JournalApp.Routers.Posts = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = new JournalApp.Collections.Posts();
    var indexView = new JournalApp.Views.PostsIndex({
      collection: this.collection
    });
    $(".sidebar").html(indexView.render().$el);
  },

  routes: {
    "": "index",
    "posts/new": "new",
    "posts/:id/edit": "edit",
    "posts/:id": "show"
  },

  edit: function(id) {
    console.log("edit!");
    var post = this.collection.getOrFetch(id);
    var view = new JournalApp.Views.PostForm({
      model: post
    });
    this._swapView(view);
  },

  index: function () {
    var posts = this.collection;
    // var view = new JournalApp.Views.PostsIndex({
    //   collection: posts
    // });
    //
    posts.fetch({ reset: true });
    // this._swapView(view);
  },

  new: function () {
    var post = new JournalApp.Models.Post();
    var view = new JournalApp.Views.PostForm({
      model: post,
      collection: this.collection
    });
    this._swapView(view);
  },

  show: function (id) {
    var post = this.collection.getOrFetch(id);
    var view = new JournalApp.Views.PostShow({
      model: post
    });
    this._swapView(view);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
});
