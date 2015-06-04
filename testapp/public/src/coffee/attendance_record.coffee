makeRow = (tableobj, rowNumber) ->
  row = tableobj.insertRow(rowNumber + 4)
  cell1 = row.insertCell(0)
  cell2 = row.insertCell(1)
  cell3 = row.insertCell(2)
  cell4 = row.insertCell(3)
  cell5 = row.insertCell(4)
  cell6 = row.insertCell(5)
  cell7 = row.insertCell(6)
  cell8 = row.insertCell(7)
  cell9 = row.insertCell(8)
  cell10 = row.insertCell(9)
  cell11 = row.insertCell(10)
  cell1.setAttribute 'class', 'table__cell'
  cell2.setAttribute 'class', 'table__cell'
  cell3.setAttribute 'class', 'table__cell--attendanceLine'
  cell4.setAttribute 'class', 'table__cell--leavingLine'
  cell5.setAttribute 'class', 'table__cell'
  cell6.setAttribute 'class', 'table__cell'
  cell7.setAttribute 'class', 'table__cell'
  cell8.setAttribute 'class', 'table__cell'
  cell9.setAttribute 'class', 'table__cell'
  cell10.setAttribute 'class', 'table__cell'
  cell11.setAttribute 'class', 'table__cell'
  data1 = '<input type="text" id="day' + rowNumber + '" readonly="readonly" class="table__insert__dayAndweek" />'
  data2 = '<input type="text" id="weekday' + rowNumber + '" readonly="readonly" class="table__insert__dayAndweek" />'
  data3 = '<input type="text" id="attendance' + rowNumber + '" class="table__insert__attendanceAndleaving" />'
  data4 = '<input type="text" id="leaving' + rowNumber + '" class="table__insert__attendanceAndleaving" />'
  data5 = '<input type="text" id="mark' + rowNumber + '" class="table__insert__mark" />'
  data6 = '<input type="text" id="midnight-work' + rowNumber + '" class="table__insert__midnightAndholidayAndprearranged">'
  data7 = '<input type="text" id="holiday-shift' + rowNumber + '" class="table__insert__midnightAndholidayAndprearranged">'
  data8 = '<input type="text" id="prearranged-holiday' + rowNumber + '" class="table__insert__midnightAndholidayAndprearranged">'
  data9 = '<input type="text" id="paid-vacation' + rowNumber + '" class="table__insert">'
  data10 = '<input type="text" id="holiday-acquisition' + rowNumber + '" class="table__insert">'
  data11 = '<input type="text" id="etc' + rowNumber + '" class="table__insert__etc">'
  cell1.innerHTML = data1
  cell2.innerHTML = data2
  cell3.innerHTML = data3
  cell4.innerHTML = data4
  cell5.innerHTML = data5
  cell6.innerHTML = data6
  cell7.innerHTML = data7
  cell8.innerHTML = data8
  cell9.innerHTML = data9
  cell10.innerHTML = data10
  cell11.innerHTML = data11
  row

save = (user_id, year, month, day) ->
  data = []
  for i in [1..day]
    data[i - 1] = {
      "day": i
      "attendance": $("#attendance#{i}").val()
      "leaving": $("#leaving#{i}").val()
      "prearranged_holiday": $("#prearranged-holiday#{i}").val()
      "paid_vacation": $("#paid-vacation#{i}").val()
      "holiday_acquisition": $("#holiday-acquisition#{i}").val()
      "etc": $("#etc#{i}").val()
    }
  request = $.ajax(
    type: 'put'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/attend-leave/#{year}/#{month}"
    dataType: 'json'
    data:
      'data': data)

make_record = (year, month) ->
  user_id = $('#user_id').val()
  day = new Date(year, month, 0).getDate()
  tableobj = document.getElementById("table")
  if tableobj.rows.length isnt 7
    deleterow = tableobj.rows.length
    for i in [8..deleterow]
      tableobj.deleteRow 5
  $('#YearsAndMonths').val "#{year}年#{month}月"
  request = $.ajax(
    type: 'get'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{user_id}/attend-leave/#{year}/#{month}"
    dataType: 'json')
    .done (msg) ->
      $('#department').val msg.department
      $('#name').val msg.name
      $('#user_id').val msg.user_id
      for i in [1..msg.data.length]
        row = makeRow(tableobj, i)
        $("#day#{i}").val msg.data[i - 1].day
        $("#weekday#{i}").val msg.data[i - 1].weekday
        $("#attendance#{i}").val msg.data[i - 1].attendance
        $("#leaving#{i}").val msg.data[i - 1].leaving
        $("#midnight-work#{i}").val msg.data[i - 1].midnight_work
        $("#holiday-shift#{i}").val msg.data[i - 1].holiday_shift
        $("#prearranged-holiday#{i}").val msg.data[i - 1].prearranged_holiday
        $("#paid-vacation#{i}").val msg.data[i - 1].paid_vacation
        $("#holiday-acquisition#{i}").val msg.data[i - 1].holiday_acquisition
        $("#etc#{i}").val msg.data[i - 1].etc
        if msg.data[i - 1].weekday is "日" or  msg.data[i - 1].weekday is "土" or msg.data[i - 1].isholiday isnt false
          row.style.backgroundColor = '#D9D9D9'
        datanumber = i
      console.log msg
  $('#save').bind 'click', ->
    year = $('#year').val()
    month = $('#month').val()
    save(user_id, year, month, day)
    .done (msg) ->
      document.location = '/userpage/read_data'

$('#select').bind 'click', ->
  year = $('#year').val()
  month = $('#month').val()
  make_record(year, month)

now = new Date
year = now.getFullYear()
month = now.getMonth() + 1
datanumber = 0
$('#year').val year
$('#month').val month
make_record(year, month)
