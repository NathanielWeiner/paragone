$(document).ready(function() {
  $(".search-object").on("submit", function(){
    var objectId = $(".search-value").val();
    console.log(objectId)
    $.post('/art_objects', {id: objectId}, function(data, status) {
      console.log("hey");
    });
  });
});