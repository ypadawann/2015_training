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
      name: name
      department: department
      new_password: newPassword
      password: password
  )

userDelete = ->
  userId = $("#user-id").text()
  $.ajax(
    type: "delete"
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}"
  )

$('#user-modify').bind 'click', ->
  userModify()
    .done (data)   ->
      $("#message").text 'ユーザ情報を変更しました'
    .fail (xhr,  status, error) ->
      if xhr.status is 403
        $("#message").text '認証に失敗しました'
      else
        $("#message").text 'エラーが発生しました'


$('#user-delete').click ->
  if !window.confirm '本当にアカウントを削除しますか？'
    $("#message").text 'アカウント削除をキャンセルしました'
  else
    userDelete()
      .done (data) ->
        alert 'アカウントを削除しました'
        document.location = '/'
      .fail (xhr,  status, error) ->
        $("#message").text 'エラーが発生しました'

switch location.pathname
  when '/userpage/modify'
    userSelect()
      .done (data) ->
        document.querySelector("#user-name").value = data.name
        ($('#department option').filter ->
          return $(this).text() is data.department).prop 'selected', true
      .fail (xhr,  status, error) ->
        if xhr.status is 403
          $("#message").text '認証に失敗しました'
        else
          $("#message").text 'エラーが発生しました'

$(document).ready ->
 $("#department").material_select()
