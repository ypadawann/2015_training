attend = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/attend"
    dataType: 'json'
    data: 'user_id': user_id)

leave = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/leave"
    dataType: 'json'
    data: 'user_id': user_id)

logout = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'put'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/logout"
    dataType: 'json'
    data: 'user_id': user_id)

view_paid_vacation_num = ->
  user_id = document.getElementById('user_id').textContent
  request = $.ajax(
    type: 'get'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/paid-vacation"
    dataType: 'json'
    )

$('#attend').bind 'click', ->
  attend()
  .done (msg) ->
    $('#attend_message').text msg.attendance + 'に出勤しました'
  .fail (msg) ->
    console.log(msg.status)
    $('#attend_message').text '本日は既に出勤しています'
$('#leave').bind 'click', ->
  leave()
  .done (msg) ->
    $('#leave_message').text msg.leaving + 'に退勤しました'
  .fail (msg) ->
    $('#leave_message').text '本日は既に退勤しています'
    console.log(msg.status)
$('#logout').bind 'click', ->
  logout()
  .done (msg) ->
    document.location = '/'
  .fail (msg) ->
    alert('エラーが発生しました')

$('#paid-vacation').bind 'click', ->
  view_paid_vacation_num()
  .done (data) ->
    alert "#{data.paid_vacation_num} 日"
  .fail (xhr) ->
    alert 'Failed'

$('#add-paid-vacation').bind 'click', ->
  document.location = '/userpage/add_paid_vacation'

$('#readdata').bind 'click', ->
  document.location = '/userpage/read_data'
$('#modify').bind 'click', ->
  document.location = '/userpage/modify'
