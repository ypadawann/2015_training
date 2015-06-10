attend = ->
  userId = document.getElementById('user-id').textContent
  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/attend"
    dataType: 'json'
    data: 'user_id': userId)

leave = ->
  userId = document.getElementById('user-id').textContent
  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/leave"
    dataType: 'json'
    data: 'user_id': userId)

logout = ->
  userId = document.getElementById('user-id').textContent
  request = $.ajax(
    type: 'put'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/logout"
    dataType: 'json'
    data: 'user_id': userId)

viewPaidVacationNum = ->
  userId = document.getElementById('user-id').textContent
  request = $.ajax(
    type: 'get'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/paid-vacation"
    dataType: 'json'
    )


# REVIEW: ここ以下、か毒性のためにも適切に改行を入れていってください
$('#attend').bind 'click', ->
  attend()
  .done (msg) ->
    $('#attend-message').text msg.attendance + 'に出勤しました'
  .fail (msg) ->
    console.log(msg.status)
    $('#attend-message').text '本日は既に出勤しています'
$('#leave').bind 'click', ->
  leave()
  .done (msg) ->
    $('#leave-message').text msg.leaving + 'に退勤しました'
  .fail (msg) ->
    $('#leave-message').text '本日は既に退勤しています'
    console.log(msg.status)
$('#logout').bind 'click', ->
  logout()
  .done (msg) ->
    document.location = '/'
  .fail (msg) ->
    alert('エラーが発生しました')

$('#view-paid-vacation').bind 'click', ->
  viewPaidVacationNum()
  .done (data) ->
    alert "#{data.paid_vacation_num} 日"
  .fail (xhr) ->
    alert 'Failed'

$('#to-add-paid-vacation').bind 'click', ->
  document.location = '/userpage/add_paid_vacation'

$('#to-read-data').bind 'click', ->
  document.location = '/userpage/attendance_record'
$('#to-modify').bind 'click', ->
  document.location = '/userpage/modify'
