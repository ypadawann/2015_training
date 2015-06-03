save = (user_id, year, month, day) ->
  data = []
  for i in [1..day]
    data[i - 1] = {
      "day": i
      "attendance": $("#attendance#{i}").val()
      "leaving": $("#leaving#{i}").val()
#     "prearranged_holiday": $("#prearranged-holiday#{i}").val()
#     "paid_vacation": $("#paid-vacation#{i}").val()
#     "holiday_acquisition": $("#holiday-acquisition#{i}").val()
#     "etc": $("#etc#{i}").val()
    }
  request = $.ajax(
    type: 'put'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/attend-leave/#{year}/#{month}"
    dataType: 'json'
    data:
      'data': data)
$('#select').bind 'click', ->
  user_id = $('#user_id').val()
  year = $('#year').val()
  month = $('#month').val()
  if month < 10
    month = "0#{month}"
  day = new Date(year, month, 0).getDate()
  if day < 10
    day = "0#{day}"
  request = $.ajax(
    type: 'get'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/attend-leave/#{year}/#{month}"
    dataType: 'json')
    .done (msg) ->
      $('#name').val msg.name
      $('#department').val msg.department
      for i in [1..msg.data.length]
        $("#attendance#{i}").val msg.data[i - 1].attendance
        $("#leaving#{i}").val msg.data[i - 1].leaving
#       $("#midnight-work#{i}").val msg.data[i - 1].midnight_work
#       $("#holiday-shift#{i}").val msg.data[i - 1].holiday_shift
#       $("#prearranged-holiday#{i}").val msg.data[i - 1].prearranged_holiday
#       $("#paid-vacation#{i}").val msg.data[i - 1].paid_vacation
#       $("#holiday-acquisition#{i}").val msg.data[i - 1].holiday_acquisition
#       $("#etc#[i]").val msg.data[i - 1].etc
      console.log msg
  $('#save').bind 'click', ->
    save(user_id, year, month, day)
    .done (msg) ->
      document.location = '/userpage/read_data'
