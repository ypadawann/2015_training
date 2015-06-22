registVacation = ->
  userId = $('#user-id').text()
  $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/paid-vacation"
    dataType: 'json'
    contentType: 'application/json'
    data: JSON.stringify(
      full_vacation: arrayToPostdata($("#full-vacation").val().split(/\s/))
      half_vacation: arrayToPostdata($("#half-vacation").val().split(/\s/))
    )
  )

arrayToPostdata = (vacation_dates) ->
  vacation_dates.map (date) -> { date:  date }

$('#regist-vacation').bind 'click', ->
  registVacation()
  .done (data) ->
    #alert '登録しました'
    Materialize.toast('登録しました', 5000, 'alert-message')
    #location.reload()
  .fail (xhr) ->
    #alert '登録に失敗しました'
    Materialize.toast('登録に失敗しました', 5000, 'alert-message')
