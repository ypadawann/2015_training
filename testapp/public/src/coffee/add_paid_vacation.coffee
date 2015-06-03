add_vacation = ->
  user_id = $('#user_id').text()
  full_array = $("#full_vacation").val().split(/\s/)
  half_array = $("#half_vacation").val().split(/\s/)

  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/paid-vacation"
    dataType: 'json'
    data:
      'full_vacation': array_to_postdata(full_array)
      'half_vacation': array_to_postdata(half_array)
    )

array_to_postdata = (array) ->
  data = []
  i = 0
  while i < array.length
    console.log tmp = { "date": array[i] }
    data.push(tmp)
    i += 1
  return data

$('#add-vacation').bind 'click', ->
  add_vacation()
  .done (msg) ->
    $('#attend_message').text msg.attendance + 'に出勤しました'
  .fail (msg) ->
    console.log(msg.status)
    $('#attend_message').text '本日は既に出勤しています'
