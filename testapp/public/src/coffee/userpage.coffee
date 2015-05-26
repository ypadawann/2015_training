attend = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'post'
    url: 'api/v1/users/' + user_id + '/attend'
    dataType: 'json'
    data: 'user_id': user_id)
  request.promise()

leave = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'post'
    url: 'api/v1/users/' + user_id + '/leave'
    dataType: 'json'
    data: 'user_id': user_id)
  request.promise()

logout = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'put'
    url: 'api/v1/users/' + user_id + '/logout'
    dataType: 'json'
    data: 'user_id': user_id)
  request.promise()

readdata = ->
  user_id = document.getElementById('user_id').textContent
  year = getFullYear()
  month = getMonth() + 1
  request = $.ajax(
    type: 'get'
    url: 'api/v1/users/' + user_id + '/attend-leave/' + year + '/' + month
    dataType: 'json'
    data:
          'user_id': user_id
          'year': year
          'month': month)
  request.promise()

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
  readdata()
    .done (msg) ->
      document.location = '/read-data'

$('#modify').bind 'click', ->
  document.location = '/userdata_modify'
