adminRegister = ->
  $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/admin/api/v1/admin"
    data:
      'admin_id'   : $('#register__admin-id').val()
      'admin_password'  : $('#register__admin-password').val()
  )


startAdminRegister = ->
  if $('#register__admin-password').val() isnt $('#register__confirm-admin-password').val()
    Materialize.toast('確認パスワードが違います', 5000, 'alert-message')  
  else
    adminRegister()
      .done (data) ->
        Materialize.toast('登録に成功しました', 5000, 'alert-message')        
        $('#modal__admin-register').closeModal()
        new_node = $( '<option />');
        new_node.text data.admin_id
        new_node.val $("#select-admin-id").children().length + 1
        $("#select-admin-id").append(new_node)
        $('#register__admin-id').val ''
        $('#register__admin-password').val ''
        $('#register__confirm-admin-password').val ''
      .fail (xhr) ->
        apiErrorToast(xhr)

$ ->
  $('#open-admin-register').bind 'click', ->
    $('#modal__admin-register').openModal()
    $('#register__admin-id').focus()
    $('#admin-register').bind 'click', ->
      event.preventDefault()
      startAdminRegister()
