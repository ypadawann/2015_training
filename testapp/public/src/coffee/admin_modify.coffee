admin_select = ->
  admin_id = $("#admin_id").val()
  deferred = $.ajax
    type:      "GET"
    url:       "http://#{location.host}/admin/api/v1/admin/#{admin_id}"
    dataType:  "json"
    context:    this

admin_modify = ->
  admin_id = $('#admin_id').val()
  admin_new_password = $('#admin_new_password').val()
  admin_password = $('#admin_password').val()
  deferred = $.ajax
    type:      "PUT"
    url:       "http://#{location.host}/admin/api/v1/admin/#{admin_id}"
    data:
      'admin_new_password': admin_new_password
      'admin_password': admin_password
    dataType:  "json"
    context:    this

admin_delete = ->
  admin_id = $("#admin_id").val()
  deferred = $.ajax
    type:      "DELETE"
    url:       "http://#{location.host}/admin/api/v1/admin/#{admin_id}"
    dataType:  "json"
    context:    this
      
$('#admin-modify').bind 'click', ->
  if $('#admin_new_password').val() isnt $('#confirm_admin_new_password').val()
    alert '確認パスワードが違います'
  else
    admin_modify()
      .done (data)   ->
         alert '管理者情報を変更しました'
         location.reload()
      .fail (xhr,  status, error) ->
        if xhr.status is 403
          alert '認証に失敗しました'
        else
          alert 'エラーが発生しました'

$('#admin-delete').bind 'click', ->
  if !window.confirm '本当にアカウントを削除しますか？'
    alert 'アカウント削除をキャンセルしました'
  else
    admin_delete()
      .done (data) ->
        alert 'アカウントを削除しました'
        location.reload()
      .fail (xhr,  status, error) ->
        alert 'エラーが発生しました'

