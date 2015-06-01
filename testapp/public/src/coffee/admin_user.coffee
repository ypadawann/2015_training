user_select = ->
  user_id = $("#user_id").val()
  deferred = $.ajax
    async:     true
    type:      "GET"
    url:       "http://#{location.host}/admin/api/v1/admin/users/#{user_id}"
    dataType:  "json"
    context:    this

user_modify = ->
  user_id = $('#user_id').val()
  deferred = $.ajax
    async:     true
    type:      "PUT"
    url:       "http://#{location.host}/admin/api/v1/admin/users/#{user_id}"
    data:
      'name': $('#name').val()
      'department': $('#department option:selected').text()
      'new_password': $('#new_password').val()
      'password': $('#password').val()
    dataType:  "json"
    context:    this

user_delete = ->
  user_id = $("#user_id").val()
  deferred = $.ajax
    async:     true
    type:      "DELETE"
    url:       "http://#{location.host}/admin/api/v1/admin/users/#{user_id}"
    dataType:  "json"
    context:    this


$('#user-select').bind 'click', ->
  user_select()
    .done (data) ->
      console.log data
      document.querySelector("#name").value = data.name
      ($('#department option').filter ->
        return $(this).text() is data.department).prop 'selected', true
    .fail (xhr,  textStatus, errorThrown) ->
      if xhr.status is 403
        alert '認証に失敗しました'
      else
        alert 'エラーが発生しました'
      
$('#modify').bind 'click', ->
  if $('#new_password').val() isnt $('#confirm_new_password').val()
    alert '確認パスワードが違います'
  else
    user_modify()
      .done (data)   ->
        alert 'ユーザ情報を変更しました'
        location.reload()
      .fail (xhr,  status, error) ->
        if xhr.status is 403
          alert '認証に失敗しました'
        else
          alert 'エラーが発生しました'

$('#delete').click ->
  if !window.confirm '本当にアカウントを削除しますか？'
    $("#message").text 'アカウント削除をキャンセルしました'
  else
    user_delete()
      .done (data) ->
        alert 'アカウントを削除しました'
        location.reload()
      .fail (xhr,  status, error) ->
        alert 'エラーが発生しました'

