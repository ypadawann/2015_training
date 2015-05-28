login = ->
  user_id = $('#user_id').val()
  password = $('#password').val()
  request = $.ajax(
    type: 'put'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/login"
    dataType: 'json'
    data:
      'user_id': user_id
      'password': password)
  request.promise()

$ ->
  $('#login').bind 'click', ->
    login().done (msg) ->
      document.location = '/'
      return
    .fail (msg) ->
      $('#error_message').text '社員番号又はパスワードが違います'
    return
  return
