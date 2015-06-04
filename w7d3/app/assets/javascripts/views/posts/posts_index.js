JournalApp.Views.PostsIndex = Backbone.View.extend({

  template: JST['posts/index'],

  initialize: function () {
    var view = this;
    this.listenTo(this.collection, "reset update sync change:title", function (event) {
      view.render();
    });
  },

  events: {
    "click .new-post": "newPost"
  },

  newPost: function (event) {
    Backbone.history.navigate(
      'posts/new',
      { trigger: true }
    );
  },

  render: function () {
    var indexView = this;
    var content = indexView.template({ posts: indexView.collection });
    indexView.$el.html(content);
    indexView.collection.each(function (post) {
      var postsIndexItem =
        new JournalApp.Views.PostsIndexItem({ model: post });
      postsIndexItem.render().$el
        .appendTo(indexView.$el.find(".posts-list"));
    });
    return this;
  }
});
