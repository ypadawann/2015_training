adminRegister = ->
  $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/admin/api/v1/admin"
    data:
      'admin_id'   : $('#admin-id').val()
      'admin_password'  : $('#admin-password').val()
  )


$('#admin-register').bind 'click', ->
  if $('#admin-password').val() isnt $('#confirm-admin-password').val()
    alert 'パスワードが違います'
  else
    adminRegister()
      .done ->
        alert '登録に成功しました'
        location.reload()
      .fail (xhr) ->
        #alert ("エラーが発生しました")
        Materialize.toast('エラーが発生しました', 5000, 'alert-message')
  
