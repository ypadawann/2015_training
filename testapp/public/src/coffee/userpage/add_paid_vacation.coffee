registVacation = ->
  userId = $('#user-id').text()
  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/paid-vacation"
    dataType: 'json'
    contentType: 'application/json'
    data: JSON.stringify(
      full_vacation: arrayToPostdata($("#full-vacation").val().split(/\s/))
      half_vacation: arrayToPostdata($("#half-vacation").val().split(/\s/))
              )
    )

arrayToPostdata = (array) ->
  data =
    array.map (array_map) ->
      { date:  array_map }
  return data

$('#regist-vacation').bind 'click', ->
  registVacation()
  .done (data) ->
    alert '登録しました'
    location.reload()
  .fail (xhr) ->
    alert '登録に失敗しました'
