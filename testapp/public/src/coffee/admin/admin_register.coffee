adminRegister = ->
  $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/admin/api/v1/admin"
    data:
      'admin_id'   : $('#admin_id').val()
      'admin_password'  : $('#admin_password').val()
  )


$('#admin-register').bind 'click', ->
  if $('#admin_password').val() isnt $('#confirm_admin_password').val()
    alert 'パスワードが違います'
  else
    adminRegister()
      .done ->
        alert '登録に成功しました'
        location.reload()
      .fail (xhr) ->
        alert ("エラーが発生しました")
