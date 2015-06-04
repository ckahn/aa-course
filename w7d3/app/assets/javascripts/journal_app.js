window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $mainEl = $(".main");

    var router = new JournalApp.Routers.Posts({ $rootEl: $mainEl });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
