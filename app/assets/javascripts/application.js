//= require jquery
//= require jquery_ujs

$(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe("/game/messages/new", function(data) {
    eval(data);
  });
});