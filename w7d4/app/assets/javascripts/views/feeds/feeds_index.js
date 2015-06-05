NewsReader.Views.FeedsIndex = Backbone.View.extend({
  initialize: function() {
    // `add` makes it slow?
    this.listenTo(this.collection, "sync remove create reset", this.render);
  },

  template: JST['feeds/index'],

  render: function () {
    var content = this.template();
    this.$el.html(content);

    this.collection.forEach(function(feed) {
      var itemView = new NewsReader.Views.FeedIndexItem({ model: feed });
      $(".index-list").append(itemView.render().$el);
    });

    var feed = new NewsReader.Models.Feed();
    var form = new NewsReader.Views.FeedNewForm({ model: feed });
    this.$el.append(form.render().$el);

    return this;
  }
});
