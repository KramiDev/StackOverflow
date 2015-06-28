$ ->
  questionEditLink()
  answerEditLink()
  removeFileField()

  $('body').on 'cocoon:after-insert', (e, insertedItem) ->
    removeFileField()

  $('.question-like').bind 'ajax:success', (e, data, status, xhr) ->
    $('.votes li.likes').html('Likes: ' + xhr.responseJSON.likes_count)
    $('li.cancel').html('<a href="">Отменить выбор</a>')
  .bind 'ajax:error', (e, xhr, status, error) ->
    clearAlertAndNotice()
    $('.alert').append('Ошибка загрузки. Возможно вы уже проголосовали.')




  $('.answer-like').bind 'ajax:success', (e, data, status, xhr) ->
    $('#answer-like-' + xhr.responseJSON.like.voteable_id + ' .likes').html('Likes: ' + xhr.responseJSON.likes_count)
  .bind 'ajax:error', (e, xhr, status, error) ->
    clearAlertAndNotice()
    $('.alert').append('Ошибка загрузки. Возможно вы уже проголосовали.')

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

