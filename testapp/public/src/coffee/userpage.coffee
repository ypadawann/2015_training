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

$ ->
  $('#attend').bind 'click', ->
    attend().done (msg) ->
      $('#attend_time').text msg.attendance + 'に出勤しました'
      return
    .fail (msg) ->
      console.log('エラーが発生しました')
      return
    return
  $('#leave').bind 'click', ->
    leave().done (msg) ->
      $('#leave_time').text msg.leaving + 'に退勤しました'
      return
    .fail (msg) ->
      console.log('エラーが発生しました')
      return
    return
  $('#logout').bind 'click', ->
    logout().done (msg) ->
      document.location = '/'
      console.log('成功？')
    return
  return
