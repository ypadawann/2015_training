registVacation = ->
  userId = $('#user-id').text()
  fullArray = $("#full-vacation").val().split(/\s/)
  halfArray = $("#half-vacation").val().split(/\s/)
  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/paid-vacation"
    dataType: 'json'
    contentType: 'application/json'
    data: JSON.stringify(
      full_vacation: arrayToPostdata(fullArray)
      half_vacation: arrayToPostdata(halfArray)
              )
    )

arrayToPostdata = (array) ->  
  data =
    _.range(array.length)
    .map (i) ->
      { date: array[i] }
  return data

$('#regist-vacation').bind 'click', ->
  registVacation()
  .done (data) ->
    alert '登録しました'
    location.reload()
  .fail (xhr) ->
    alert '登録に失敗しました'
