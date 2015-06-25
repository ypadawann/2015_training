userId = $('#current-user-id').text()

if (document.getElementById("attend-message") isnt null)
  $.ajax(
    type: 'get'
    url: "//#{location.host}/api/v1/users/#{userId}/attend")
    .done (attendance) ->
      $('#attend-message').text "本日は#{attendance}に出勤しました"
    .fail (msg) ->
      console.log $('#attend-message').text JSON.parse(msg.responseText).error

  $.ajax(
    type: 'get'
    url: "//#{location.host}/api/v1/users/#{userId}/leave")
    .done (leave) ->
      $('#leave-message').text "本日は#{leave}に退勤しました"
    .fail (msg) ->
      console.log $('#leave-message').text JSON.parse(msg.responseText).error

attend = ->
  $.ajax(
    type: 'post'
    url: "//#{location.host}/api/v1/users/#{userId}/attend"
    data: 'user_id': userId
  )

leave = ->
  $.ajax(
    type: 'post'
    url: "//#{location.host}/api/v1/users/#{userId}/leave"
    data: 'user_id': userId
  )

logout = ->
  $.ajax(
    type: 'put'
    url: "//#{location.host}/api/v1/users/#{userId}/logout"
    data: 'user_id': userId
  )

viewPaidVacationNum = ->
  $.ajax(
    type: 'get'
    url: "//#{location.host}/api/v1/users/#{userId}/paid-vacation"
  )

$('#attend').bind 'click', ->
  attend()
  .done (msg) ->
    $('#attend-message').text "#{msg.attendance}に出勤しました"
  .fail (msg) ->
    Materialize.toast(JSON.parse(msg.responseText).error, 5000, 'alert-message')

$('#leave').bind 'click', ->
  leave()
  .done (msg) ->
    $('#leave-message').text "#{msg.leaving}に退勤しました"
  .fail (msg) ->
    Materialize.toast(JSON.parse(msg.responseText).error, 5000, 'alert-message')

$('#logout').bind 'click', ->
  logout()
  .done (msg) ->
    document.location = '/'
  .fail (msg) ->
    Materialize.toast('エラーが発生しました', 5000, 'alert-message')

$('#view-paid-vacation').bind 'click', ->
  viewPaidVacationNum()
  .done (data) ->
    Materialize.toast("#{data.paid_vacation_num} 日", 5000, 'alert-message')
  .fail (xhr) ->
    Materialize.toast('Failed', 5000, 'alert-message')

$('#to-add-paid-vacation').bind 'click', ->
  document.location = '/userpage/add_paid_vacation'

$('#to-read-data').bind 'click', ->
  document.location = '/userpage/attendance_record'

$('#to-modify').bind 'click', ->
  document.location = '/userpage/modify'
