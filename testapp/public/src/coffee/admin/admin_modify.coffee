adminSelect = ->
  adminId = $("#admin-id").val()
  deferred = $.ajax
    type:      "GET"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/#{adminId}"
    dataType:  "json"
    context:    this

adminModify = ->
  adminId =  $('#select-admin-id option:selected').text()
  deferred = $.ajax
    type:      "PUT"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/#{adminId}"
    data:
      'admin_new_password': $('#admin-new-password').val()
      'admin_password': $('#admin-password').val()
    dataType:  "json"
    context:    this

adminDelete = ->
  adminId =  $('#select-admin-id option:selected').text()
  deferred = $.ajax
    type:      "DELETE"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/#{adminId}"
    dataType:  "json"
    context:    this

$('#admin-modify').bind 'click', ->
  if $('#admin-new-password').val() isnt $('#confirm-admin-new-password').val()
    Materialize.toast('確認パスワードが違います', 5000, 'alert-message')
  else
    adminModify()
      .done (data)   ->
        Materialize.toast('管理者情報を変更しました', 5000, 'alert-message')
        ($('#select-department option').filter ->
          $(this).text() is $('#login-admin-id')).prop 'selected', true
        $('#admin-new-password').val ''
        $('#confirm-admin-new-password').val ''
        $('#admin-password').val ''
      .fail (xhr, status, error) ->
        apiErrorToast(xhr)

startAdminDelete = ->
  adminDelete()
    .done (data) ->
      $("#select-admin-id option:selected").remove()
      Materialize.toast('アカウントを削除しました', 50000, 'alert-message')
      ($('#select-department option').filter ->
        $(this).text() is $('#login-admin-id')).prop 'selected', true
      $('#admin-new-password').val ''
      $('#confirm-admin-new-password').val ''
      $('#admin-password').val ''
    .fail (xhr, status, error) ->
      apiErrorToast(xhr)

$ ->
  $('#admin-delete').leanModal({
    ready: ->
      $('#admin-delete-agree').bind 'click', ->
        startAdminDelete()
    })
