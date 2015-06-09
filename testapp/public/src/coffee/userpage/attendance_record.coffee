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
  cell1.setAttribute 'class', 'attendance-record__table__cell--dayAndweek'
  cell2.setAttribute 'class', 'attendance-record__table__cell--dayAndweek'
  cell3.setAttribute 'class', 'attendance-record__table__cell--attendanceLine'
  cell4.setAttribute 'class', 'attendance-record__table__cell--leavingLine'
  cell5.setAttribute 'class', 'attendance-record__table__cell--mark'
  cell6.setAttribute 'class', 'attendance-record__table__cell--midnightAndholidayAndprearranged'
  cell7.setAttribute 'class', 'attendance-record__table__cell--midnightAndholidayAndprearranged'
  cell8.setAttribute 'class', 'attendance-record__table__cell--midnightAndholidayAndprearranged'
  cell9.setAttribute 'class', 'attendance-record__table__cell'
  cell10.setAttribute 'class', 'attendance-record__table__cell'
  cell11.setAttribute 'class', 'attendance-record__table__cell--etc'
  data1 = '<input type="text" id="day' + rowNumber + '" readonly="readonly" class="attendance-record__table__insert" />'
  data2 = '<input type="text" id="weekday' + rowNumber + '" readonly="readonly" class="attendance-record__table__insert" />'
  data3 = '<input type="text" id="attendance' + rowNumber + '" class="attendance-record__table__insert" />'
  data4 = '<input type="text" id="leaving' + rowNumber + '" class="attendance-record__table__insert" />'
  data5 = '<input type="text" id="mark' + rowNumber + '" class="attendance-record__table__insert" />'
  data6 = '<input type="text" id="midnight-work' + rowNumber + '" readonly="readonly"  class="attendance-record__table__insert" />'
  data7 = '<input type="text" id="holiday-shift' + rowNumber + '" readonly="readonly" class="attendance-record__table__insert" />'
  data8 = '<input type="text" id="prearranged-holiday' + rowNumber + '" class="attendance-record__table__insert" />'
  data9 = '<input type="text" id="paid-vacation' + rowNumber + '" class="attendance-record__table__insert" />'
  data10 = '<input type="text" id="holiday-acquisition' + rowNumber + '" class="attendance-record__table__insert" />'
  data11 = '<input type="text" id="etc' + rowNumber + '" class="attendance-record__table__insert" />'
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

save = (userId, year, month, day) ->
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
  console.log data
  request = $.ajax(
    type: 'put'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/attend-leave/#{year}/#{month}"
    dataType: 'json'
    data:
      'data': data)

makeRecord = (year, month) ->
  console.log userId = $('#user-id').val()
  console.log day = new Date(year, month, 0).getDate()
  tableobj = document.getElementById("table")
  if tableobj.rows.length isnt 7
    deleterow = tableobj.rows.length
    for i in [8..deleterow]
      tableobj.deleteRow 5
  $('#YearsAndMonths').val "#{year}年#{month}月"
  request = $.ajax(
    type: 'get'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/attend-leave/#{year}/#{month}"
    dataType: 'json')
    .done (msg) ->
      $('#department').val msg.department
      $('#name').val msg.name
      $('#user-id').val msg.user_id
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
      
$('#timecard-save').bind 'click', ->
  year = $('#year').val()
  month = $('#month').val()
  userId = $('#user-id').val()
  console.log day = new Date(year, month, 0).getDate()
  save(userId, year, month, day)
    .done (msg) ->
      makeRecord(year, month)

$('#date-select').bind 'click', ->
  year = $('#year').val()
  month = $('#month').val()
  makeRecord(year, month)

switch location.pathname
  when '/userpage/attendance_record'
    now = new Date
    year = now.getFullYear()
    month = now.getMonth() + 1
    datanumber = 0
    $('#year').val year
    $('#month').val month
    makeRecord(year, month)