
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
  cell1.setAttribute("class", "ex9");
  cell2.setAttribute("class", "ex9");
  cell3.setAttribute("class", "ex7");
  cell4.setAttribute("class", "ex8");
  cell5.setAttribute("class", "ex9");
  cell6.setAttribute("class", "ex9");
  cell7.setAttribute("class", "ex9");
  cell8.setAttribute("class", "ex9");
  cell9.setAttribute("class", "ex9");
  cell10.setAttribute("class", "ex9");
  cell11.setAttribute("class", "ex9");

  var HTML1 = '<input type="text" id="day' + rowNumber + '" readonly="readonly" style="width:27; height:21; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var HTML2 = '<input type="text" id="week' + rowNumber + '" readonly="readonly" style="width:27; height:21; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var HTML3 = '<input type="text" id="attendance' + rowNumber + '" style="width:75; height:21; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var HTML4 = '<input type="text" id="leaving' + rowNumber + '" style="width:75; height:21; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var HTML5 = '<input type="text" id="mark' + rowNumber + '" style="width:64; height:21; border:none; background:none; text-align:center; vertical-align:middle; font-size:6px;" />';
  var HTML6 = '';
  var HTML7 = '';
  var HTML8 = '';
  var HTML9 = '';
  var HTML10 = '';
  var HTML11 = '';
  cell1.innerHTML = HTML1;
  cell2.innerHTML = HTML2;
  cell3.innerHTML = HTML3;
  cell4.innerHTML = HTML4;
  cell5.innerHTML = HTML5;
  cell6.innerHTML = HTML6;
  cell7.innerHTML = HTML7;
  cell8.innerHTML = HTML8;
  cell9.innerHTML = HTML9;
  cell10.innerHTML = HTML10;
  cell11.innerHTML = HTML11;
  return row;
};


var isWeekEnds = function(weekDay) {
  return weekDay === 0 || weekDay === 6;
};

var shunbun = function(year){
  if(year < 1900 || year >2099){
    return 0;
  }
  if(year % 4 === 0){
    return year <= 1956 ? 21 : (year <= 2088 ? 20 :19);
  } else if(year % 4 === 1){
    return year <= 1989 ? 21 : 20;
  } else if(year % 4 === 2){
    return year <= 2022 ? 21 : 20;
  } else {
    return year <= 1923 ? 22 :(year <= 2055 ? 21 :20);
  }
};

var shubun = function(year){
  if(year < 1900 || year > 2099){
    return 0;
  }
  if(year % 4 === 0){
    return year <= 2008 ? 23 : 22;
  } else if(year % 4 === 1){
    return year <= 1917 ? 24 : (year <= 2041 ? 23 : 22);
  } else if(year % 4 === 2){
    return year <= 1946 ? 24 : (year <= 2074 ? 23 : 22);
  } else {
    return year <= 1979 ? 24 :23;
  }
};

var isHolidays = function(year,month, day, weekDay, makeHoliday){
  if(month === 1 && day === 1){
    return true;
  }
  if(month === 2 && day === 11){
    return true;
  }
  if(month === 4 && day === 29){
    return true;
  }
  if(month === 5 && day === 3){
    return true;
  }
  if(month === 5 && day === 4){
    return true;
  }
  if(month === 5 && day === 5){
    return true;
  }
  if(year >=2016 && month === 8 && day ===11){
    return true;
  }
  if(month === 11 && day === 3){
    return true;
  }
  if(month === 11 && day === 23){
    return true;
  }
  if(month === 12 && day === 23){
    return true;
  }
  if(month === 1 && weekDay === 1 && 7 < day && day < 15){
    return true;
  }
  if(month === 7 && weekDay === 1 && 14 < day && day < 22){
    return true;
  }
  if(month === 9 && weekDay === 1 && 14 < day && day < 22){
    return true;
  }
  if(month === 10 && weekDay === 1 && 7 < day && day < 15){
    return true;
  }
  if(month === 3 && day === shunbun(year)){
    return true;
  }
  if(month === 9 && day === shubun(year)){
    return true;
  }
  if(year === 2015 && month === 9 && day === 22){
    return true;
  }
  if(year === 2026 && month === 9 && day === 22){
    return true;
  }
  if(year === 2032 && month === 9 && day === 21){
    return true;
  }
  if(year === 2037 && month === 9 && day === 22){
    return true;
  }
  if(year === 2043 && month === 9 && day === 22){
    return true;
  }
  if(year === 2049 && month === 9 && day === 21){
    return true;
  }
  if(year === 2054 && month === 9 && day === 22){
    return true;
  }
  if(year === 2060 && month === 9 && day === 21){
    return true;
  }
  if(year === 2065 && month === 9 && day === 22){
    return true;
  }
  if(year === 2071 && month === 9 && day === 22){
    return true;
  }
  if(year === 2077 && month === 9 && day === 21){
    return true;
  }
  if(year === 2088 && month === 9 && day === 21){
    return true;
  }
  if(year === 2094 && month === 9 && day === 21){
    return true;
  }
  if(year === 2099 && month === 9 && day === 22){
    return true;
  }
  
  return false;
};

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
    // TODO: 後でクラスを使って色を変える
    row.style.backgroundColor = "D9D9D9";
  }
  if(isHolidays(year,month,counter,weekDayOfFirstDay)){
    row.style.backgroundColor = "D9D9D9";
    if(weekDayOfFirstDay === 0){
      makeHoliday ++;
    }
  }else if(makeHoliday === 1){
    row.style.backgroundColor = "D9D9D9";
    makeHoliday --;
  }
  // 曜日の循環をリセットしている
  if (weekDayOfFirstDay === 6) {
    weekDayOfFirstDay =- 1;
  }
  weekDayOfFirstDay++;
}

document.getElementById("YearsAndMonths").value = year+"年"+month+"月";
