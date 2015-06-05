NewsReader.Models.Feed = Backbone.Model.extend({

  urlRoot: "/api/feeds",

  parse: function (payload) {
    if (payload.latest_entries) {
      this.entries().set(payload.latest_entries);
      delete payload.latest_entries;
    }
    return payload;
  },

  entries: function () {
    if (!this._entries) {
      this._entries = new NewsReader.Collections.Entries([], { feed: this });
    }
    return this._entries;
  }

});
