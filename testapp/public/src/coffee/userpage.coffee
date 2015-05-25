attend ->
  usesr_id = document.getElementById('user_id').textContent;
  request = $.ajax({
    type: 'post',
    url: 'api/v1/users/' + user_id + '/attend',
    dataType: 'json',
    data: {
      'user_id': user_id,
    }
  })
  return request.promise()

leave ->
  user_id = document.getElementById('user_id').textContent;
  request = $/ajax({
    type: 'post',
    url: 'api/v1/users/' + user_id + '/leave',
    dataType: 'json',
    data: {
      'user_id': user_id,
    }
  })
  return request.promise();

$ ->
  $('#attend').bind 'click', ->
    attend().done (msg) ->
      $('#attend_time').text(msg.time + "に出勤しました")
    return
  return

  $('#leave').bind 'click', ->
    leave().done (msg) ->
      $('#leave_time').text msg.leaving + 'に退勤しました'
    return
  return
