
_ = require 'lodash'

# REVIEW: arrayという名前では配列型であることしかわからないので良くないです
arrayToPostdata = (array) ->  
  # REVIEW: ここではindexをとらずにそのままmapして良いのでは？
  #         また、今のJSのListはmapメソッドを持っているので、ここでlodashは不要です。
  data =
    _.range(array.length)
    .map (i) ->
      { date: array[i] }
  return data


registVacation = ->
  userId = $('#user-id').text()
  # REVIEW: ここでも、変数に型名を入れる必要はありません
  fullArray = $("#full-vacation").val().split(/\s/)
  halfArray = $("#half-vacation").val().split(/\s/)
  # REVIEW: 不要な変数への代入はやめましょう
  request = $.ajax(
    type: 'post'
    url: "#{location.protocol}//#{location.host}/api/v1/users/#{userId}/paid-vacation"
    dataType: 'json'
    contentType: 'application/json'
    data: JSON.stringify(
      full_vacation: arrayToPostdata(fullArray)
      half_vacation: arrayToPostdata(halfArray)
              )
    )


$('#regist-vacation').bind 'click', ->
  registVacation()
  .done (data) ->
    alert '登録しました'
    # REVIEW: reloadするのであればajaxを使う理由はないのでは？
    location.reload()
  .fail (xhr) ->
    alert '登録に失敗しました'
