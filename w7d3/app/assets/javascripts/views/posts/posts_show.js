JournalApp.Views.PostShow = Backbone.View.extend({
  events: {
    "click a.back-to-index": "backToIndex",
    "click a.edit-post": "goToEdit"
  },

  template: JST['posts/show'],

  initialize: function () {
    var view = this;
    this.listenTo(this.model, "sync", function (event) {
      view.render();
    });
  },

  backToIndex: function () {
    Backbone.history.navigate('', { trigger: true});
  },

  goToEdit: function (event) {
    Backbone.history.navigate(
      'posts/' + this.model.id + '/edit',
      { trigger: true }
    );
  },

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  }
});
