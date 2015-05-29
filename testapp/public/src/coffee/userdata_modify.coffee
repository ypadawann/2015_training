user_select = ->
  user_id = $("#user_id").text()
  deferred = $.ajax
    async:     true
    type:      "GET"
    url:       "/api/v1/users/#{user_id}"
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}"
    dataType:  "json"
    context:    this
  deferred.promise()

user_modify = ->
  console.log user_id = $('#user_id').text()
  console.log name = $('#name').val()
  console.log department = $('#department option:selected').text()
  console.log new_password = $('#new_password').val()
  console.log password = $('#password').val()
  deferred = $.ajax
    async:     true
    type:      "PUT"
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}"
    data: { name: name, department: department, new_password: new_password, password: password }
    dataType:  "json"
    context:    this
  deferred.promise()

user_delete = ->
  user_id = $("#user_id").text()
  deferred = $.ajax
    async:     true
    type:      "DELETE"
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}"
    dataType:  "json"
    context:    this
  deferred.promise()


$('#modify').bind 'click', ->
  user_modify()
    .done (data)   ->
      $("#message").text 'ユーザ情報を変更しました'
    .fail (xhr,  status, error) ->
      if xhr.status is 403
        $("#message").text '認証に失敗しました'
      else
        $("#message").text 'エラーが発生しました'


$('#delete').click ->
  if !window.confirm '本当にアカウントを削除しますか？'
    $("#message").text 'アカウント削除をキャンセルしました'
  else
    user_delete()
      .done (data) ->
        alert 'アカウントを削除しました'
        document.location = '/'
      .fail (xhr,  status, error) ->
        $("#message").text 'エラーが発生しました'

do ->
user_select()
    .done (data) ->
      document.querySelector("#name").value = data.name
      ($('#department option').filter ->
        return $(this).text() is data.department).prop 'selected', true
    .fail (xhr,  status, error) ->
      if xhr.status is 403
        $("#message").text '認証に失敗しました'
      else
        $("#message").text 'エラーが発生しました'


