adminSelect = ->
  adminId = $("#admin-id").val()
  deferred = $.ajax
    type:      "GET"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/#{adminId}"
    dataType:  "json"
    context:    this

adminModify = ->
  adminId = $('#admin-id').val()
  deferred = $.ajax
    type:      "PUT"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/#{adminId}"
    data:
      'admin_new_password': $('#admin-new-password').val()
      'admin_password': $('#admin-password').val()
    dataType:  "json"
    context:    this

adminDelete = ->
  adminId = $("#admin-id").val()
  deferred = $.ajax
    type:      "DELETE"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/#{adminId}"
    dataType:  "json"
    context:    this

$('#admin-modify').bind 'click', ->
  if $('#admin-new-password').val() isnt $('#confirm-admin-new-password').val()
    alert '確認パスワードが違います'
  else
    adminModify()
      .done (data)   ->
         alert '管理者情報を変更しました'
         location.reload()
      .fail (xhr,  status, error) ->
        if xhr.status is 403
          #alert '認証に失敗しました'
          Materialize.toast('認証に失敗しました', 5000, 'alert-message')
        else
          #alert 'エラーが発生しました'
          Materialize.toast('エラーが発生しました', 5000, 'alert-message')

$('#admin-delete').bind 'click', ->
  if !window.confirm '本当にアカウントを削除しますか？'
    alert 'アカウント削除をキャンセルしました'
  else
    adminDelete()
      .done (data) ->
        alert 'アカウントを削除しました'
        location.reload()
      .fail (xhr,  status, error) ->
        #alert 'エラーが発生しました'
        Materialize.toast('エラーが発生しました', 5000, 'alert-message')


