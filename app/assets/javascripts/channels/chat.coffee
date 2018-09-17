App.chat = App.cable.subscriptions.create "ChatChannel",

  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
      $('#message').append data['message']

  speak: (message, room_id, sender_id, teacher, read) ->
      @perform 'speak', message: message, room_id: room_id, sender_id: sender_id, teacher: teacher, read: read

  $(document).on 'keypress', '[data-behavior~=chat_speaker]', (event) ->
    if event.keyCode is 13 # return = send
      App.chat.speak(
        event.target.value,
        $('[data-behavior~=chat_room]').val(),
        $('[data-behavior~=chat_sender]').val(),
        $('[data-behavior~=chat_teacher]').val()
        $('[data-behavior~=chat_read]').val()
      )
      event.target.value = ' '
      event.preventDefault()
