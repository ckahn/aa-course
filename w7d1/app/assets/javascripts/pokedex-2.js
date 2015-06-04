Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $toy = $("<li class=poke-list-item>");
  $toy.text(toy.get("name") + " "
    + toy.get("happiness") + " "
    + toy.get("price"));

  $(".pokemon-detail ul").append($toy);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $details =
    $("<div>").addClass("detail")
              .append("<img src=" + toy.escape("image_url") + ">")

  debugger;
  this.$toyDetail.append($details);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
};
