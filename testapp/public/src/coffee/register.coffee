require 'es5-shim'

$ ->
  $('#register').bind 'click', ->
    register()
    .done ->
      login()
      .done ->
        document.location = '/'
      .fail (xhr) ->
        Materialize.toast(JSON.parse(xhr.responseText).error, 5000, 'alert-message')
    .fail (xhr) ->
      Materialize.toast(JSON.parse(xhr.responseText).error, 5000, 'alert-message')

  register = ->
    year = $("#enter_year").val()
    month = $("#enter_month").val()
    day = $("#enter_day").val()
    $.ajax(
      type: 'post'
      url: "//#{location.host}/api/v1/users"
      data:
        'user_id'   : $('#user_id').val()
        'name'      : $('#name').val()
        'department': $('#department option:selected').text()
        'password'  : $('#password').val()
        'enter_date' : [year, month, day].join('-')
    )

  login = ->
    $.ajax(
      type: 'put'
      url: "//#{location.host}/api/v1/users/#{$('#user_id').val()}/login"
      data:
        'user_id' : $('#user_id').val()
        'password': $('#password').val()
    )
  $(document).ready ->
    $("#department").material_select()
