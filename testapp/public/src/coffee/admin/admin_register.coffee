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
    Materialize.toast('確認パスワードが違います', 5000, 'alert-message')  
  else
    adminRegister()
      .done ->
        Materialize.toast('登録に成功しました', 5000, 'alert-message')
        $('#admin-id').val ''
        $('#admin-password').val ''
        $('#confirm-admin-password').val ''
        location.href='#'
      .fail (xhr) ->
        Materialize.toast('エラーが発生しました', 5000, 'alert-message')
  
