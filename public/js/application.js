$(document).ready(function () {
  // PSEUDO-CODE:
  //   1- intercept the form submission event using jQuery
  //   2- prevent the default action for that event from happening
  //   3- use jQuery to submit an AJAX post to the form's action
  //   4- when the AJAX post is done, display the new die roll using jQuery
  $('body').on('click', '.comment-link', function(event){
    event.preventDefault();
    // debugger
    var url = $(this).attr('href');
    var $commentLink = $(this);
    $.ajax({
      url: url,
      type: 'GET',
    })
    .done(function(response) {
      $commentLink.hide();
      $('#comment-box').append(response);
    });

  });

});
