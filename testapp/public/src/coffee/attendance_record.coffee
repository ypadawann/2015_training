save = (user_id, year, month, day) ->
  data = []
  for i in [1..day]
    data[i - 1] = {
      "day": i
      "attendance": $("#attendance#{i}").val()
      "leaving": $("#leaving#{i}").val()
    }
  request = $.ajax(
    type: 'put'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/attend-leave/#{year}/#{month}"
    dataType: 'json'
    data:
      'user_id': user_id
      'year': year
      'month': month
      'data': data)

user_id = $('#user_id').val()
now = new Date
year = now.getFullYear()
month = now.getMonth() + 1
if month < 10
  month = "0#{month}"
day = new Date(year, month, 0).getDate()
if day < 10
  day = "0#{day}"
#TODO関数化
request = $.ajax(
  type: 'get'
  url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/attend-leave/#{year}/#{month}"
  dataType: 'json'
  data:
    'user_id': user_id
    'name': name
    'year': year
    'month': month)
  .done (msg) ->
    $('#name').val msg.name
    $('#department').val msg.department
    for i in [1..msg.data.length]
      $("#attendance#{i}").val msg.data[i - 1].attendance
      $("#leaving#{i}").val msg.data[i - 1].leaving
      if msg.data[i - 1].leaving > '22:00'
        $("#graveyard-shift#{i}").val msg.data[i - 1].leaving
    console.log msg
$('#save').bind 'click', ->
  save(user_id, year, month, day)
  .done (msg) ->
    document.location = '/read_data'
