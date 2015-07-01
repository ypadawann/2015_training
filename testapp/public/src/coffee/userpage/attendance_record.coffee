_ = require 'lodash'
userId = $('#current-user-id').text()

moveToNextRow = ->
  if event.keyCode == 13
    i = $(this).index()
    $(this).parent().next().children().eq(i).children().first().focus()

makeRow = (row, rowNumber) ->
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
  data1 = '<div id="day' + rowNumber + '" class="attendance-record__table__insert" />'
  data2 = '<div id="weekday' + rowNumber + '" class="attendance-record__table__insert" />'
  data3 = '<input type="text" id="attendance' + rowNumber + '" maxlength="5" class="attendance-record__table__insert" />'
  data4 = '<input type="text" id="leaving' + rowNumber + '" maxlength="5" class="attendance-record__table__insert" />'
  data5 = '<div id="mark' + rowNumber + '" class="attendance-record__table__insert" />'
  data6 = '<div id="midnight-work' + rowNumber + '" class="attendance-record__table__insert" />'
  data7 = '<div id="holiday-shift' + rowNumber + '" class="attendance-record__table__insert" />'
  data8 = '<input type="text" id="prearranged-holiday' + rowNumber + '" maxlength="10" class="attendance-record__table__insert" />'
  data9 = '<input type="text" id="paid-vacation' + rowNumber + '" maxlength="3" class="attendance-record__table__insert" />'
  data10 = '<input type="text" id="holiday-acquisition' + rowNumber + '" maxlength="10" class="attendance-record__table__insert" />'
  data11 = '<input type="text" id="etc' + rowNumber + '" maxlength="50" class="attendance-record__table__insert" />'
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
  $(cell3).bind 'keydown', moveToNextRow
  $(cell4).bind 'keydown', moveToNextRow
  $(cell8).bind 'keydown', moveToNextRow
  $(cell10).bind 'keydown', moveToNextRow
  $(cell11).bind 'keydown', moveToNextRow

save = (year, month) ->
  day = new Date(year, month, 0).getDate()
  data =
    _.range(1, day + 1)
    .map (i) ->
      {
        day: i
        attendance: $("#attendance#{i}").val()
        leaving: $("#leaving#{i}").val()
        prearranged_holiday: $("#prearranged-holiday#{i}").val()
        paid_vacation: $("#paid-vacation#{i}").val()
        holiday_acquisition: $("#holiday-acquisition#{i}").val()
        etc: $("#etc#{i}").val()
      }
  $.ajax(
    type: 'put'
    url: "//#{location.host}/api/v1/users/#{userId}/attend-leave/#{year}/#{month}"
    dataType: 'json'
    contentType: 'application/json'
    data:
      JSON.stringify(data: data)
  )

getRecords = (year, month) ->
  $.ajax(
    type: 'get'
    url: "//#{location.host}/api/v1/users/#{userId}/attend-leave/#{year}/#{month}"
    dataType: 'json'
  )

setTable = (table, data_length) ->
  _.range(table.rows.length, data_length, 1).map (i) ->
    row = table.insertRow(-1)
    makeRow(row, i + 1)
  _.range(table.rows.length, data_length, -1).map (i) ->
    table.deleteRow(-1)

showRecords = (year, month) ->
  getRecords(year, month)
  .done (msg) ->
    $('#YearsAndMonths').text "#{year}年#{month}月"
    setTable($('#table')[0], msg.data.length)
    _.forEach(msg.data, (data) ->
      i = data.day
      $("#day#{i}").text                data.day
      $("#weekday#{i}").text            data.weekday
      $("#attendance#{i}").val          data.attendance
      $("#leaving#{i}").val             data.leaving
      $("#midnight-work#{i}").text      data.midnight_work
      $("#holiday-shift#{i}").text      data.holiday_shift
      $("#prearranged-holiday#{i}").val data.prearranged_holiday
      $("#paid-vacation#{i}").val       data.paid_vacation
      $("#holiday-acquisition#{i}").val data.holiday_acquisition
      $("#etc#{i}").val                 data.etc
      row = $("#table tr:nth-child(#{i})")
      if data.isholiday
        row.addClass 'attendance-record__table__row--holiday'
      else if row.hasClass 'attendance-record__table__row--holiday'
        row.removeClass 'attendance-record__table__row--holiday'
    )
    $("#total-midnight-work").text msg.total.midnight_work
    $("#total-holiday-shift").text msg.total.holiday_shift
    $("#total-paid-vacation").text msg.total.paid_vacation

$('#timecard-save').bind 'click', ->
  year = $('#year').val()
  month = $('#month').val()
  save(year, month)
  .done (msg) ->
    showRecords(year, month)
    Materialize.toast('保存しました。', 5000)
  .fail (xhr, status, error) ->
    Materialize.toast(JSON.parse(xhr.responseText).error, 5000, 'alert-message')

$('#date-select').bind 'click', ->
  year = $('#year').val()
  month = $('#month').val()
  showRecords(year, month)

$('#exportCSV').bind 'click', ->
  year = $('#year').val()
  month = $('#month').val()
  document.location =
    "//#{location.host}/api/v1/users/#{userId}/attend-leave/#{year}/#{month}/export"

$ ->
  switch location.pathname
    when '/userpage/attendance_record'
      year = $('#year').val()
      month = $('#month').val()
      showRecords(year, month)
