userId = $('#current-user-id').text()

registVacation = ->
  $.ajax(
    type: 'post'
    url: "//#{location.host}/api/v1/users/#{userId}/paid-vacation"
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
    Materialize.toast('登録しました', 5000, 'alert-message')
  .fail (xhr) ->
    Materialize.toast('登録に失敗しました', 5000, 'alert-message')

moveToNextItem = ->
  if event.keyCode == 13 && $(this).find('input[type="text"]').value != ''
    $(this).parent().next().find('input[type="text"]').focus()

appendNewItem = ->
  $(this).unbind('focus')
  item = newItem()
  $('#full-vacations').append item

newItem = ->
  field = $('<input class="add-paid-vacation datepicker" type="text" placeholder="yyyy-mm-dd" style="width: 90%"/>')
  $('.datepicker').pickadate({
    format: 'yyyy-mm-dd',
    selectMonths: true,
    selectYears: 10
  })
  field.bind 'keydown', moveToNextItem
  field.bind 'focus', appendNewItem
  item = $('<div/>').append(field)
  item

$ ->
  switch location.pathname
    when '/userpage/add_paid_vacation'
      item = newItem()
      $('#full-vacations').append item
