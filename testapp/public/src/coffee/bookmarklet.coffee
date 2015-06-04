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

complete_message = ->
  alert 'comp'
  $('#bookmarklet_msg').text 'comp'

bookmarklet_attend = ->
  alert 'attend'
  attend()
    .done (data) ->
      alert 'attend ok'
      complete_message()
    .fail (xhr) ->
      alert 'attend ng'
      complete_message()

bookmarklet_leave = ->
    leave()
      .done (data) ->
        alert 'leave ok'
      .fail (xhr) ->
        alert 'leave ng'



bookmarklet_action = $('#bookmarklet_action').text()
switch bookmarklet_action
  when "attend"
    bookmarklet_attend()
  when "leave"
    bookmarklet_leave()
    
###
console.log  action = $('#action').text()
bookmarklet_action(action)
  .done (msg) ->
    alert 'ok'
  .fail (msg) ->
    alert 'ng'
###
