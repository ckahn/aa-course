NewsReader.Views.FeedNewForm = Backbone.View.extend({

  events: {
    "submit form": "createFeed"
  },

  template: JST['feeds/new_form'],

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  },

  createFeed: function (event) {
    event.preventDefault();
    var attrs = $(event.currentTarget).serializeJSON();
    var feed = new NewsReader.Models.Feed(attrs.feed);
    feed.save({}, {
      success: function () {
        NewsReader.feeds.add(feed);
      },
      errors: function () {
        console.log("FAILED");
      }
    });
  }
});
