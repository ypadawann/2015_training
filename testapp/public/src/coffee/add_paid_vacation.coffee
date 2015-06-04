add_vacation = ->
  user_id = $('#user_id').text()
  full_array = $("#full_vacation").val().split(/\s/)
  half_array = $("#half_vacation").val().split(/\s/)
  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/paid-vacation"
    dataType: 'json'
    contentType: 'application/json'
    data: JSON.stringify(
      full_vacation: array_to_postdata(full_array)
      half_vacation: array_to_postdata(half_array)
              )
    )

array_to_postdata = (array) ->
  data = []
  i = 0
  while i < array.length
    tmp = { date: array[i] }
    data.push(tmp)
    i += 1
  return data

$('#add-vacation').bind 'click', ->
  add_vacation()
  .done (msg) ->
    alert '登録しました'
    location.reload()
  .fail (msg) ->
    console.log(msg.status)
    alert '登録に失敗しました'
