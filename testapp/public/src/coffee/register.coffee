require 'es5-shim'

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
        'user_id'   : $('#user_id').val()
        'name'      : $('#name').val()
        'department': $('#department option:selected').text()
        'password'  : $('#password').val()
        'enter_date' : date
    )

  login = ->
    $.ajax(
      type: 'put'
      url: "#{location.protocol}//#{location.host}/api/v1/users/#{$('#user_id').val()}/login"
      data:
        'user_id' : $('#user_id').val()
        'password': $('#password').val()
    )
  $(document).ready ->
    $("#department").material_select()
