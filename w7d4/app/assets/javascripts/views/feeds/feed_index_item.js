NewsReader.Views.FeedIndexItem = Backbone.View.extend({
  events: {
    'click button': "delete"
  },

  template: JST["feeds/index_item"],

  tagName: 'li',

  render: function() {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  },

  delete: function (event) {
    event.preventDefault();
    this.model.destroy();
  }
});
