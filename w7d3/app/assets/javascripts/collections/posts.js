JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: '/posts',
  model: JournalApp.Models.Post,

  getOrFetch: function (id) {
    var collection = this;
    var post = this.get(id);
    if (post) {
      post.fetch();
    } else {
      post = new JournalApp.Models.Post({id: id});
      post.fetch({
        success: function () {
          collection.add(post);
        }
      });
    }
    return post;
  }
});
