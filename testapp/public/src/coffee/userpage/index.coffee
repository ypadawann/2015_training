attend = ->
  userId = document.getElementById('user-id').textContent
  $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/attend"
    data: 'user_id': userId
  )

leave = ->
  userId = document.getElementById('user-id').textContent
  $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/leave"
    data: 'user_id': userId
  )

logout = ->
  userId = document.getElementById('user-id').textContent
  $.ajax(
    type: 'put'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/logout"
    data: 'user_id': userId
  )

viewPaidVacationNum = ->
  userId = document.getElementById('user-id').textContent
  $.ajax(
    type: 'get'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/paid-vacation"
  )

$('#attend').bind 'click', ->
  attend()
  .done (msg) ->
    $('#attend-message').text msg.attendance + 'に出勤しました'
  .fail (msg) ->
    $('#attend-message').text JSON.parse(msg.responseText).error

$('#leave').bind 'click', ->
  leave()
  .done (msg) ->
    $('#leave-message').text msg.leaving + 'に退勤しました'
  .fail (msg) ->
    $('#leave-message').text JSON.parse(msg.responseText).error

$('#logout').bind 'click', ->
  logout()
  .done (msg) ->
    document.location = '/'
  .fail (msg) ->
    alert('エラーが発生しました')

$('#view-paid-vacation').bind 'click', ->
  viewPaidVacationNum()
  .done (data) ->
    #alert "#{data.paid_vacation_num} 日"
    Materialize.toast("#{data.paid_vacation_num} 日", 5000, 'alert-message')
  .fail (xhr) ->
    #auert 'Failed'
    Materialize.toast('Failed', 5000, 'alert-message')

$('#to-add-paid-vacation').bind 'click', ->
  document.location = '/userpage/add_paid_vacation'

$('#to-read-data').bind 'click', ->
  document.location = '/userpage/attendance_record'

$('#to-modify').bind 'click', ->
  document.location = '/userpage/modify'
