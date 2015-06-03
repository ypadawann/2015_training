
$ ->
  $('#register').bind 'click', ->
    register()
    .done ->
      login()
      .done ->
        document.location = '/'
      .fail (xhr) ->
        alert ("#{xhr.status} #{xhr.statusText}")
    .fail (xhr) ->
      alert ("#{xhr.status} #{xhr.statusText}")

  register = ->
    year = $("#enter_year").val()
    month = $("#enter_month").val()
    day = $("#enter_day").val()
    date = new Date(year, month - 1, day)
    $.ajax(
      type: 'post'
      url: "#{location.protocol}//#{location.host}/api/v1/users"
      data:
        'user_id'   : $('#no').val()
        'name'      : $('#name').val()
        'department': $('#department option:selected').text()
        'password'  : $('#pass').val()
        'enter_date'      : date
    )

  login = ->
    $.ajax(
      type: 'put'
      url: "#{location.protocol}//#{location.host}/api/v1/users/#{$('#no').val()}/login"
      data:
        'user_id' : $('#no').val()
        'password': $('#pass').val()
    )
