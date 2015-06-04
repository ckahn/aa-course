JournalApp.Views.PostForm = Backbone.View.extend({

  template: JST['posts/form'],

  events: {
    "submit form": "handleFormSubmission"
  },

  handleFormSubmission: function (event) {
    event.preventDefault();
    $(".errors").empty();
    var postAttributes = $('form').serializeJSON();
    this.model.save(postAttributes, {
      success: function () {
        this.collection && this.collection.add(this.model);
        Backbone.history.navigate('posts/' + this.model.id, { trigger: true });
      }.bind(this),

      error: function (model, response) {
        $(".errors").html(response.responseJSON);
      }
    });
  },

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);

    return this;
  }
});
