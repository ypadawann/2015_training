require 'es5-shim'

attend = ->
  user_id = document.getElementById('user_id').textContent
  $.ajax(
    type: 'post'
    url: "//#{location.host}/api/v1/users/#{user_id}/attend"
    data: 'user_id': user_id
  )

leave = ->
  user_id = document.getElementById('user_id').textContent
  $.ajax(
    type: 'post'
    url: "//#{location.host}/api/v1/users/#{user_id}/leave"
    data: 'user_id': user_id
  )

bookmarklet_attend = ->
  attend()
    .done (data) ->
      $('#bookmarklet_result').text '出勤時間を登録しました。'
      bookmarklet_success()
    .fail (xhr) ->
      $('#bookmarklet_result').text '出勤時間の登録に失敗しました'
      switch xhr.status
        when 400
          msg = 'すでに出勤しています'
        when 403
          msg = 'セッションが不正です'
      $('#bookmarklet_message').text msg


bookmarklet_leave = ->
  leave()
    .done (data) ->
      $('#bookmarklet_result').text '退勤時間を登録しました。'
      bookmarklet_success()
    .fail (xhr) ->
      $('#bookmarklet_result').text '退勤時間の登録に失敗しました'
      switch xhr.status
        when 400
          msg = 'すでに退勤しています'
        when 403
          msg = 'セッションが不正です'
        when 404
          msg = 'まだ出勤していません'
      $('#bookmarklet_message').text msg

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
