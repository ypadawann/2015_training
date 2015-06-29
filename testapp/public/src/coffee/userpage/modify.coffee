userId = $('#current-user-id').text()

userSelect = ->
  $.ajax(
    type: "get"
    url: "//#{location.host}/api/v1/users/#{userId}"
  )

userModify = ->
  userName = $('#user-name').val()
  department = $('#department option:selected').text()
  newPassword = $('#new-password').val()
  password = $('#password-for-modifying').val()
  enterDate =
    year: $('#enter-year').val()
    month: $('#enter-month').val()
    day: $('#enter-day').val()
  $.ajax(
    type: "put"
    url: "//#{location.host}/api/v1/users/#{userId}"
    data:
      name: userName
      department: department
      new_password: newPassword
      enter_date: enterDate
      password: password
  )

userDelete = ->
  password = $('#password-for-deleting').val()
  $.ajax(
    type: "post"
    url: "//#{location.host}/api/v1/users/delete/#{userId}"
    data:
      password: password
  )

$('#user-modify').bind 'click', ->
  userModify()
    .done (data)   ->
      Materialize.toast('ユーザ情報を変更しました', 5000, 'alert-message')
      setTimeout( ->
        location.reload()
      ,1500)
    .fail (xhr,  status, error) ->
      if xhr.status is 403
        Materialize.toast('認証に失敗しました', 5000, 'alert-message')
      else
        Materialize.toast('エラーが発生しました', 5000, 'alert-message')

switch location.pathname
  when '/userpage/modify'
    userSelect()
      .done (data) ->
        $('#user-name').val data.name
        $('#department').val data.department
        $('#department').material_select()
        $('#enter-year').val data.enter_date.year
        $('#enter-month').val data.enter_date.month
        $('#enter-day').val data.enter_date.day
      .fail (xhr,  status, error) ->
        if xhr.status is 403
          Materialize.toast('認証に失敗しました', 5000, 'alert-message')
        else
          Materialize.toast('エラーが発生しました', 5000, 'alert-message')

$('#ok').bind 'click', ->
  userDelete()
    .done (data) ->
      Materialize.toast('アカウントを削除しました', 5000, 'alert-message')
      setTimeout( ->
        document.location = '/'
      , 1500)
    .fail (xhr, status, error) ->
      if xhr.status is 403
        Materialize.toast('認証に失敗しました', 5000, 'alert-message')
        setTimeout( ->
          location.reload()
        ,1500 )
      else
        Materialize.toast('エラーが発生しました', 5000, 'alert-message')
        setTimeout( ->
          location.reload()
        ,1500 )

$('#cancel').bind 'click', ->
  Materialize.toast('アカウント削除をキャンセルしました', 1500, 'alert-message')
  setTimeout( ->
    location.reload()
  ,1500 )

$(document).ready ->
  $('.modal-trigger').leanModal(
      opacity: .5,
      in_duration: 300,
      out_duration: 200,
  )
