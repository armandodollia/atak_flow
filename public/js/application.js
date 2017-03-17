$(document).ready(function () {
  $("#new_comment_button").on("click", function(){
    $("#new_comment_button").hide();
    $("#new_comment_form").fadeIn("slow");
 })

  $("#new_comment_form").on("submit", function(event){
    event.preventDefault();
    $("#new_comment_form").hide().trigger('reset');
    $("#new_comment_button").fadeIn("slow");
  })
});
