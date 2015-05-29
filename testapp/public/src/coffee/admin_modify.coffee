admin_select = ->
  admin_id = $("#admin_id").val()
  deferred = $.ajax
    type:      "GET"
    url:       "./api/v1/admin/#{admin_id}"
    dataType:  "json"
    context:    this

admin_modify = ->
  admin_id = $('#admin_id').val()
  admin_name = $('#admin_name').val()
  admin_new_password = $('#admin_new_password').val()
  admin_password = $('#admin_password').val()
  deferred = $.ajax
    type:      "PUT"
    url:       "./api/v1/admin/#{admin_id}"
    data:
      'admin_name': admin_name
      'admin_new_password': admin_new_password
      'admin_password': admin_password
    dataType:  "json"
    context:    this

admin_delete = ->
  admin_id = $("#admin_id").val()
  deferred = $.ajax
    type:      "DELETE"
    url:       "./api/v1/admin/#{admin_id}"
    dataType:  "json"
    context:    this


$('#admin-select').bind 'click', ->
  admin_select()
    .done (data) ->
      console.log data
      document.querySelector("#admin_name").value = data.admin_name
    .fail (xhr,  status, error) ->
      console.log xhr.responseText
      console.log xhr.statusText
      if xhr.status is 403
        $("#message").text "認証に失敗しました"
      else
        $("#message").text "エラーが発生しました"
      
$('#admin-modify').bind 'click', ->
  admin_modify()
    .done (data)   ->
      $("#message").text 'ユーザ情報を変更しました'
    .fail (xhr,  status, error) ->
      if xhr.status is 403
        $("#message").text '認証に失敗しました'
      else
        $("#message").text 'エラーが発生しました'

$('#admin-delete').click ->
  if !window.confirm '本当にアカウントを削除しますか？'
    $("#message").text 'アカウント削除をキャンセルしました'
  else
    admin_delete()
      .done (data) ->
        alert 'アカウントを削除しました'
        location.reload()
      .fail (xhr,  status, error) ->
        $("#message").text 'エラーが発生しました'

