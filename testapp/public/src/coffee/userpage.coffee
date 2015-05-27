attend = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'post'
    url: 'api/v1/users/#{user_id}/attend'
    dataType: 'json'
    data: 'user_id': user_id)

leave = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'post'
    url: 'api/v1/users/#{user_id}/leave'
    dataType: 'json'
    data: 'user_id': user_id)

logout = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'put'
    url: 'api/v1/users/' + user_id + '/logout'
    dataType: 'json'
    data: 'user_id': user_id)

$('#attend').bind 'click', ->
  attend()
    .done (msg) ->
      $('#attend_message').text msg.attendance + 'に出勤しました'
    .fail (msg) ->
      console.log(msg.status)
      $('#attend_message').text '本日は既に出勤しています'
$('#leave').bind 'click', ->
  leave().done (msg) ->
    $('#leave_message').text msg.leaving + 'に退勤しました'
  .fail (msg) ->
      $('#leave_message').text '本日は既に退勤しています'
      console.log(msg.status)
$('#logout').bind 'click', ->
  logout().done (msg) ->
    document.location = '/'
  .fail (msg) ->
      alert('エラーが発生しました')
$('#readdata').bind 'click', ->
  document.location = '/read_data'
$('#modify').bind 'click', ->
  document.location = '/userdata_modify'
