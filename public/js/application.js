$(document).ready(function () {
// THIS DOESNT WORK, WILL REMAKE USING AJAX.
//this stuff does though
  $('body').on('click', '#new_answer_title', function (event) {
    var $answerFormContainer = $('#new_answer_form_container')
    event.preventDefault()
    $answerFormContainer.fadeIn()
    $(this).hide()
  });

  $('body').on('click', '.comment-link', function(event){
    event.preventDefault();
    var $commentLink = $(this)
    // debugger
    var url = $(this).attr('href');
    var $commentLink = $(this);
    $.ajax({
      url: url,
      type: 'GET',
    })
    .done(function(response) {
      $commentLink.hide();
      $commentLink.closest('div').append(response);
    });
  });


  $('body').on('submit', '#new_answer_form', function (event) {
    var $answerForm = $('#new_answer_form')
    event.preventDefault()


    $.ajax({
      url: $answerForm.attr('action'),
      method: $answerForm.attr('method'),
      data: $answerForm.serialize()
    }).done(function (answer) {
      $('#new_answer_title').show()
      $('#new_answer_form_container').hide()
    }).fail(function () {
      alert("Please put some text in your answer")
    });
  });

  $('body').on('submit', '.vote_form', function (event) {
    event.preventDefault();
    var $voteForm = $(this)

    $.ajax({
      url: $voteForm.attr('action'),
      method: $voteForm.attr('method'),
      data: $voteForm.serialize()
    }).done(function (params) {
      $voteForm.closest('.container').find('span').text(params.points);
    });
  });
});
