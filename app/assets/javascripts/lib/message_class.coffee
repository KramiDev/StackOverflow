class @Message

  message: (path, message) ->
    $(path).show()
    $(path).append(message)
    Message::out(path)

  out: (path) ->
    setTimeout ->
      $(path).slideUp()
    , 5000

  clear: (path) ->
    $(path).html('')


