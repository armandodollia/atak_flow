$(document).ready(function () {
  $('body').on('click', '#new_answer_title', function (event) {
    var $answerFormContainer = $('#new_answer_form_container')
    event.preventDefault()
    $answerFormContainer.show()
    $(this).hide()
  });

  $('body').on('submit', '#new_answer_form', function (event) {
    var $answerForm = $('#new_answer_form')
    event.preventDefault()


    $.ajax({
      // url: '/questions/'+ '8' +'/answers',
      url: $answerForm.attr('action'),
      method: $answerForm.attr('method'),
      data: $answerForm.serialize()
    }).done(function (answer) {
      $('#answers_container').append(answer)
      $('#new_answer_title').show()
      $('#new_answer_form_container').hide()
    }).fail(function () {
      alert("Please put some text in your answer")
    });
  });
});
