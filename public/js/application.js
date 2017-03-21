$(document).ready(function () {
  $('#question-index-actions').on('click', '#new-question-link', function(event){
    event.preventDefault();
    var $link = $(this);
    var url = $link.attr('href');
    var request = $.ajax({
      url: url
    })
    request.done(function(response){
      $link.after(response);
      $link.hide();
    });
  });

  $('#question-index-actions').on('submit', '#new_question_form', function(event){
    event.preventDefault();
    var $form = $(this);
    var form = new formScrape($(this));

    var request = $.ajax({
      url: form.url,
      method: form.type,
      data: form.data
    })
    request.done(function(response){
      $('.error_container').remove();
      $form.closest('div').remove();
      $("#question-index-list").append(response);
      $('#new-question-link').show();
    })
    request.fail(function(response){
      $('.error_container').remove();
      $form.before(response);
    });
  });

  $('body').on('click', '.comment-link', function(event){
    event.preventDefault();
    var $commentLink = $(this);
    var url = $commentLink.attr('href');
    var request = $.ajax({
      url: url
    });
    request.done(function(response) {
      $commentLink.hide();
      $commentLink.closest('.card-action').append(response);
    });
  });

  // making the new comment form popup.
  $('#question_container').on('click', '.new_comment_button', newCommentForm);
  $('#answers_container').on('click', '.new_comment_button', newCommentForm);

  // submission of a new comment
  $('#question_container').on('submit', '.new_comment_form', submitNewComment);
  $('#answers_container').on('submit', '.new_comment_form', submitNewComment);

  $('#answer-actions').on('click', '#new_answer_title', function (event) {
    event.preventDefault()
    var $answerFormContainer = $('#new_answer_form_container')
    $answerFormContainer.fadeIn()
    $(this).hide()
  });

  $('#answer-actions').on('submit', '#new_answer_form', function (event) {
    event.preventDefault()
    var $form = $(this)
    var form = new formScrape($(this));

    var request = $.ajax({
      url: form.url,
      method: form.type,
      data: form.data
    })
    request.done(function (answer) {
      $('#answers_container').append(answer);
      $('#new_answer_title').show()
      $('#new_answer_form_container').hide()
    })
    request.fail(function () {
      alert("Please put some text in your answer")
    });
  });

  $('body').on('submit', '.vote_form', function (event) {
    event.preventDefault();
    var $form = $(this)
    var form = new formScrape($(this));

    var request = $.ajax({
      url: form.url,
      method: form.type,
      data: form.data
    })
    request.done(function (params) {
      $form.closest('.container').find('span').text(params.points);
    });
  });
});

//******************HELPY THINGS I LIKE
function formScrape (formObject){
  this.url = formObject.attr('action');
  this.type = formObject.attr('method');
  this.data = formObject.serialize();
}

function newCommentForm(e){
  e.preventDefault();
  var $button = $(this);
  var url = $button.attr('href');
  var request = $.ajax({
      url: url
    });
  request.done(function(response) {
    $button.after(response);
    $button.hide();
  })
}

function submitNewComment(e){
  e.preventDefault();
  var $form = $(this)
  var form = new formScrape($(this));

  var request = $.ajax({
    url: form.url,
    type: form.type,
    data: form.data
  });
  request.done(function(response) {
    $('.error_container').remove();
    $form.closest('.card-action').append(response)
    $form.closest('.container').remove();
    $(".new_comment_button").show();
  });
  request.fail(function(response) {
    $('.error_container').remove();
    $form.before(response.responseText);
  });
}
