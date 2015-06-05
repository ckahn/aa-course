NewsReader.Views.FeedShow = Backbone.CompositeView.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.entries(), "add", this.addEntry);
  },

  template: JST["feeds/show"],

  events: {
    "click .refresh-feed": "refresh"
  },

  addEntry: function (entry) {
    var entryView = new NewsReader.Views.ShowItem({ model: entry });
    this.addSubview(".show-item-list", entryView);
  },

  refresh: function (event) {
    event.preventDefault();
    this.model.fetch();
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
