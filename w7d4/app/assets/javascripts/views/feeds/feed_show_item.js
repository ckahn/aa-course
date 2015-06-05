NewsReader.Views.ShowItem = Backbone.View.extend({

  template: JST["feeds/show_item"],

  tagName: 'li',

  render: function () {
    var content = this.template({ entry: this.model });
    this.$el.append(content);
    return this;
  }

});
