require 'es5-shim'

login = ->
  user_id = $('#user_id').val()
  password = $('#password').val()
  $.ajax(
    type: 'put'
    url: "//#{location.host}/api/v1/users/#{user_id}/login"
    data:
      'user_id': user_id
      'password': password
  )


$('#login').bind 'click', ->
  event.preventDefault()
  login()
  .done (msg) ->
    document.location = '/'
  .fail (msg) ->
    Materialize.toast('社員番号又はパスワードが違います', 5000, 'alert-message')
