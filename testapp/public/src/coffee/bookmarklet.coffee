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

bookmarklet_attend = ->
  attend()
    .done (data) ->
      $('#bookmarklet_result').text '出勤時間を登録しました。'
      bookmarklet_success()
    .fail (xhr) ->
      $('#bookmarklet_result').text '退勤時間の登録に失敗しました'

bookmarklet_leave = ->
    leave()
      .done (data) ->
        $('#bookmarklet_result').text '退勤時間を登録しました。'
        bookmarklet_success()
      .fail (xhr) ->
        $('#bookmarklet_result').text '退勤時間の登録に失敗しました'

bookmarklet_success = ->
  $('#bookmarklet_message').text '5秒後にウィンドウを閉じます。'
  setTimeout ->
    window.close()
  , 5000

$ ->
  bookmarklet_action = $('#bookmarklet_action').text()
  switch bookmarklet_action
    when "attend"
      bookmarklet_attend()
    when "leave"
      bookmarklet_leave()
