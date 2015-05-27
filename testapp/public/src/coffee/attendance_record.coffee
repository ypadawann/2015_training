user_id = $('#user_id').val()
now = new Date
year = now.getFullYear()
one_digit_month = now.getMonth() + 1
month = ("0" + one_digit_month).slice(-2)
request = $.ajax(
  type: 'get'
  url: 'api/v1/users/' + user_id + '/attend-leave/' + year + '/' + month
  dataType: 'json'
  data:
    'user_id': user_id
    'name': name
    'year': year
    'month': month)
  .done (msg) ->
    $('#name').val msg.name
    $('#department').val msg.department

    for i in [0..msg.data.length-1]
      $('#attendance' + (i + 1)).val msg.data[i].attendance
      $('#leaving' + (i + 1)).val msg.data[i].leaving
