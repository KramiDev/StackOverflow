$ ->
  allScripts()
  questionEditLink()
  answerEditLink()
  removeFileField()
  questionCancel()

  $('body').on 'cocoon:after-insert', (e, insertedItem) ->
    removeFileField()

  $('.question-like').bind 'ajax:success', (e, data, status, xhr) ->
    $('.votes li.likes').html('Likes: ' + xhr.responseJSON.likes_count)
    $('li.cancel').html('<a class="question-cancel" data-type="json" data-remote="true" rel="nofollow" data-method="delete" href="/votes/1?question_id=1">Отменить выбор</a>')
    questionCancel()
  .bind 'ajax:error', (e, xhr, status, error) ->
    clearAlertAndNotice()
    $('.alert').append('Ошибка загрузки. Возможно вы уже проголосовали.')

  $('.answer-like').bind 'ajax:success', (e, data, status, xhr) ->
    $('#answer-like-' + xhr.responseJSON.like.voteable_id + ' .likes').html('Likes: ' + xhr.responseJSON.likes_count)
  .bind 'ajax:error', (e, xhr, status, error) ->
    clearAlertAndNotice()
    $('.alert').append('Ошибка загрузки. Возможно вы уже проголосовали.')

window.allScripts = ->
  window.questionCancel = ->
    $('.question-cancel').bind 'ajax:success', (e, data, status, xhr) ->
      $('.votes li.likes').html('Likes: ' + xhr.responseJSON.likes_count)
      $('li.cancel').html('')
    .bind 'ajax:error', (e, xhr, status, error) ->
      clearAlertAndNotice()
      $('.alert').append('Удалить не удалось. Попробуйте позже')


  window.clearAlertAndNotice = ->
    $('.notice').html('')
    $('.alert').html('')

  window.questionEditLink = ->
    $('.question-edit-link').click (e)->
      e.preventDefault()
      $('#question-edit-form').show()

  window.answerEditLink = ->
    $('.answer-edit-link').click (e) ->
      e.preventDefault()
      data = $(this).data('answerId')
      $('form#edit_answer_' + data).show()
      $('.answer-delete-link').hide()

  window.removeFileField = ->
    $('a.remove_fields.dynamic').click (e)->
      e.preventDefault()
      $(this).parent('.form-group').remove()
      removeFileField()

