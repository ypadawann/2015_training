userSelect = ->
  userId = $("#user-id").val()
  deferred = $.ajax
    async:     true
    type:      "GET"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    dataType:  "json"
    context:    this

userModify = ->
  userId = $('#user-id').val()
  deferred = $.ajax
    async:     true
    type:      "PUT"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    data:
      'name': $('#user-name').val()
      'department': $('#select-department option:selected').text()
      'new_password': $('#user-new-password').val()
    dataType:  "json"
    context:    this

userDelete = ->
  userId = $("#user-id").val()
  deferred = $.ajax
    async:     true
    type:      "DELETE"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    dataType:  "json"
    context:    this


$('#user-select').bind 'click', ->
  userSelect()
    .done (data) ->
      document.querySelector("#user-name").value = data.name
      ($('#select-department option').filter ->
        return $(this).text() is data.department).prop 'selected', true
    .fail (xhr,  textStatus, errorThrown) ->
      if xhr.status is 403
        Materialize.toast('認証に失敗しました', 5000, 'alert-message')
      else
       Materialize.toast('エラーが発生しました', 5000, 'alert-message')

$('#user-modify').bind 'click', ->
  if $('#user-new-password').val() isnt $('#confirm-user-new-password').val()
    #alert '確認パスワードが違います'
    Materialize.toast('パスワードが違います', 5000, 'alert-message')
  else
    userModify()
      .done (data)   ->
        alert 'ユーザ情報を変更しました'
        location.reload()
      .fail (xhr,  status, error) ->
        if xhr.status is 403
          Materialize.toast('認証に失敗しました', 5000, 'alert-message')
        else
          Materialize.toast('エラーが発生しました', 5000, 'alert-message')

$('#user-delete').click ->
  if !window.confirm '本当にアカウントを削除しますか？'
    $("#message").text 'アカウント削除をキャンセルしました'
  else
    userDelete()
      .done (data) ->
        alert 'アカウントを削除しました'
        location.reload()
      .fail (xhr,  status, error) ->
        Materialize.toast('エラーが発生しました', 5000, 'alert-message')
