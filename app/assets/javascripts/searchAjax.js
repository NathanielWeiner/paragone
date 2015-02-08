$(document).ready(function() {
  $(".search-object").on("submit", function(){
    var objectId = $(".search-value").val();
    console.log(objectId)
    $.post('/art_objects', {id: objectId}, function(data, status) {
    });
  });
  $(".fa-twitter").on("click", function(){
    var objectId = $(".fa-twitter").attr('id');
    console.log(objectId);
    $.post("/art_objects/" + objectId + "/tweet_this", {theId: objectId}, function(data, status) {
    });
  });
});