userSelect = ->
  userId = $("#user-id").text()
  $.ajax(
    type: "get"
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}"
  )

userModify = ->
  userId = $('#user-id').text()
  userName = $('#user-name').val()
  department = $('#department option:selected').text()
  newPassword = $('#new-password').val()
  password = $('#password').val()
  $.ajax(
    type: "put"
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}"
    data:
      name: userName
      department: department
      new_password: newPassword
      password: password
  )

userDelete = ->
  userId = $("#user-id").text()
  password = $('#password').val()
  $.ajax(
    type: "post"
    url: "#{location.protocol}//#{location.host}/api/v1/users/delete/#{userId}"
    data:
      password: password
  )

$('#user-modify').bind 'click', ->
  userModify()
    .done (data)   ->
      Materialize.toast('ユーザ情報を変更しました', 5000, 'alert-message')
    .fail (xhr,  status, error) ->
      if xhr.status is 403
        Materialize.toast('認証に失敗しました', 5000, 'alert-message')
      else
        Materialize.toast('エラーが発生しました', 5000, 'alert-message')

switch location.pathname
  when '/userpage/modify'
    userSelect()
      .done (data) ->
        document.querySelector("#user-name").value = data.name
        ($('#department option').filter ->
          return $(this).text() is data.department).prop 'selected', true
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
        ,1500)
      else
        Materialize.toast('エラーが発生しました', 5000, 'alert-message')
        setTimeout( ->
          location.reload()
        ,1500 )

$('#cancel').bind 'click', ->
  Materialize.toast('アカウント削除をキャンセルしました', 1500, 'alert-message')
  setTimeout( ->
    location.reload()
  , 1500)

$(document).ready ->
  $("#department").material_select()
  $('.modal-trigger').leanModal(
      opacity: .5,
      in_duration: 300,
      out_duration: 200,
  )
