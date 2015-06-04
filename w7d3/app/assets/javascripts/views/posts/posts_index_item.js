JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  tagName: "li",
  template: JST['posts/index_item'],
  events: {
    "click button.delete-post": "deletePost",
    "click .edit-post": "goToEdit",
    "click .show-post": "goToShow"
  },

  initialize: function () {
    var view = this;
    this.listenTo(this.model, "remove", function (event) {
      view.render();
    });
  },

  goToEdit: function (event) {
    Backbone.history.navigate(
      'posts/' + this.model.id + '/edit',
      { trigger: true }
    );
  },

  goToShow: function (event) {
    Backbone.history.navigate(
      'posts/' + this.model.id,
      { trigger: true }
    );
  },

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  deletePost: function (event) {
    this.model.destroy();
    this.remove();
  },
});
