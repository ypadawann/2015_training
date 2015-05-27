logout = ->
  deferred = $.ajax
    async:     true
    type:      "GET"
    url:       "/api/v1/admin/logout"
    dataType:  "json"
    context:    this



$('#admin-user').bind 'click', ->
  document.location = '/admin/user'

$('#admin-department').bind 'click', ->
  document.location = '/admin/department'

$('#admin-logout').bind 'click', ->
  if !window.confirm '本当にアカウントを削除しますか？'
    $("#message").text 'アカウント削除をキャンセルしました'
  else
    user_delete()
      .done (data) ->
        alert 'アカウントを削除しました'
        document.location = '/'
      .fail (xhr,  status, error) ->
        $("#message").text 'エラーが発生しました'

