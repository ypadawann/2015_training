
var makeRow = function(table, rowNumber) {
  var row = table1.insertRow(rowNumber + 4);
  var cell1 = row.insertCell(0);
  var cell2 = row.insertCell(1);
  var cell3 = row.insertCell(2);
  var cell4 = row.insertCell(3);
  var cell5 = row.insertCell(4);
  var cell6 = row.insertCell(5);
  var cell7 = row.insertCell(6);
  var cell8 = row.insertCell(7);
  var cell9 = row.insertCell(8);
  var cell10 = row.insertCell(9);
  var cell11 = row.insertCell(10);
  cell1.setAttribute("class", "line");
  cell2.setAttribute("class", "line");
  cell3.setAttribute("class", "attendanceLine");
  cell4.setAttribute("class", "leavingLine");
  cell5.setAttribute("class", "line");
  cell6.setAttribute("class", "line");
  cell7.setAttribute("class", "line");
  cell8.setAttribute("class", "line");
  cell9.setAttribute("class", "line");
  cell10.setAttribute("class", "line");
  cell11.setAttribute("class", "line");

  var data1 = '<input type="text" id="day' + rowNumber + '" readonly="readonly" style="width:27px; height:21px; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var data2 = '<input type="text" id="week' + rowNumber + '" readonly="readonly" style="width:27px; height:21px; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var data3 = '<input type="text" id="attendance' + rowNumber + '" value="' + json_obj[rowNumber - 1].attendance + '" style="width:75px; height:21px; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var data4 = '<input type="text" id="leaving' + rowNumber + '" value="' + json_obj[rowNumber - 1].leaving + '" style="width:75px; height:21px; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var data5 = '<input type="text" id="mark' + rowNumber + '" style="width:64px; height:21px; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var data6 = '';
  var data7 = '';
  var data8 = '';
  var data9 = '';
  var data10 = '';
  var data11 = '';
  cell1.innerHTML = data1;
  cell2.innerHTML = data2;
  cell3.innerHTML = data3;
  cell4.innerHTML = data4;
  cell5.innerHTML = data5;
  cell6.innerHTML = data6;
  cell7.innerHTML = data7;
  cell8.innerHTML = data8;
  cell9.innerHTML = data9;
  cell10.innerHTML = data10;
  cell11.innerHTML = data11;
  return row;
};


var isWeekEnds = function(weekDay) {
  return weekDay === 0 || weekDay === 6;
};

var isHolidays = function(year, month, day){
  var getHoliday = new Array();
  getHoliday[1] = {1 : "元旦", 12 : "成人の日"};
  getHoliday[2] = {11 : "建国記念の日"};
  getHoliday[3] = {21 : "春分の日"};
  getHoliday[4] = {29 : "昭和の日"};
  getHoliday[5] = {3 : "憲法記念日", 4 : "みどりの日", 5 : "こどもの日"};
  getHoliday[7] = {20 : "海の日"};
//GetHoliday[8] = {11 : "山の日"}; 2016年から
  getHoliday[9] = {21 : "敬老の日", 9 : "国民の休日", 23 : "秋分の日"};
  getHoliday[10] = {12 : "体育の日"};
  getHoliday[11] = {3 : "文化の日", 23 :"勤労感謝の日"};
  getHoliday[12] = {23 : "天皇誕生日"};

  if(getHoliday[month][day] != null){
    return true;
  }
  return false;
};


var text = document.querySelector(".text").textContent;
var json_obj = JSON.parse(text);


var ROW_NUMBER_OF_HEADER = 5;
var DATE_OF_WEEKS = ["日", "月", "火", "水", "木", "金", "土"];

var now = new Date();
var year = now.getFullYear();
var month = now.getMonth() + 1;
var firstDayOfMonth = new Date(year, month - 1, 1);
var weekDayOfFirstDay = firstDayOfMonth.getDay();
var date = new Date(year, month, 0).getDate();
var makeHoliday = 0;
for (var counter=1; counter<=date; counter++) {
  var table1 = document.getElementById("table1");
  var row = makeRow(table1, counter);
  document.getElementById("day" + counter).value = counter;
  document.getElementById("week" + counter).value = DATE_OF_WEEKS[weekDayOfFirstDay];

  if (isWeekEnds(weekDayOfFirstDay)) {
    row.style.backgroundColor = "#D9D9D9";
  }
  if(isHolidays(year,month,counter)){
    row.style.backgroundColor = "#D9D9D9";
    //振替休日
    if(weekDayOfFirstDay === 0){
      makeHoliday ++;
    }
  }else if(makeHoliday === 1){
    row.style.backgroundColor = "#D9D9D9";
    makeHoliday --;
  }
  // 曜日の循環をリセットしている
  if (weekDayOfFirstDay === 6) {
    weekDayOfFirstDay =- 1;
  }
  weekDayOfFirstDay++;
}
document.getElementById("YearsAndMonths").value = year+"年"+month+"月";
