userSelect = ->
  userId = $("#user-id").val()
  deferred = $.ajax
    async:     true
    type:      "GET"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    dataType:  "json"
    context:    this

userModify = ->
  userId = $('#user-id').val()
  deferred = $.ajax
    async:     true
    type:      "PUT"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    data:
      'name': $('#user-name').val()
      'department': $('#select-department option:selected').text()
      'new_password': $('#user-new-password').val()
    dataType:  "json"
    context:    this

userDelete = ->
  userId = $("#user-id").val()
  deferred = $.ajax
    async:     true
    type:      "DELETE"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    dataType:  "json"
    context:    this


$('#user-select').bind 'click', ->
  userSelect()
    .done (data) ->
      document.querySelector("#user-name").value = data.name
      ($('#select-department option').filter ->
        $(this).text() is data.department).prop 'selected', true
    .fail (xhr,  textStatus, errorThrown) ->
      if xhr.status is 403
        Materialize.toast('認証に失敗しました', 5000, 'alert-message')
      else
       Materialize.toast('エラーが発生しました', 5000, 'alert-message')

$('#user-modify').bind 'click', ->
  if $('#user-new-password').val() isnt $('#confirm-user-new-password').val()
    Materialize.toast('パスワードが違います', 5000, 'alert-message')
  else
    userModify()
      .done (data)   ->
        Materialize.toast('ユーザ情報を変更しました', 5000, 'alert-message')
        $('#user-new-password').val ''
        $('#confirm-user-new-password').val ''
      .fail (xhr,  status, error) ->
        if xhr.status is 403
          Materialize.toast('認証に失敗しました', 5000, 'alert-message')
        else
          Materialize.toast('エラーが発生しました', 5000, 'alert-message')

startUserDelete = ->
  userDelete()
    .done (data) ->
      Materialize.toast('アカウントを削除しました', 5000, 'alert-message')
      $('#user-id').val ''
      $('#user-name').val ''
      ($('#select-department option').filter ->
        $(this).text() is '部署を選択' ).prop 'selected', true
      $('#user-new-password').val ''
      $('#confirm-user-new-password').val ''
    .fail (xhr,  status, error) ->
      Materialize.toast('エラーが発生しました', 5000, 'alert-message')

$ ->
  $('#user-delete').leanModal({
    ready: ->
      $('#user-delete-agree').bind 'click', ->
        startUserDelete()
    })
