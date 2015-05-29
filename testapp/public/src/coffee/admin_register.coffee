admin_register = ->
  $.ajax(
    type: 'post'
    url: "http://#{location.host}/admin/api/v1/admin"
    data:
      'admin_id'   : $('#admin_id').val()
      'admin_password'  : $('#admin_password').val()
  )


$('#admin-register').bind 'click', ->
  if $('#admin_password').val() isnt $('#confirm_admin_password').val()
    alert 'パスワードが違います'
  else
    admin_register()
      .done ->
        alert '登録に成功しました'
        location.reload()
      .fail (xhr) ->
        alert ("#{xhr.status} #{xhr.statusText}")
