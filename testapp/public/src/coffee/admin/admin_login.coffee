adminLlogin = ->
  deferred = $.ajax
    type: 'PUT'
    url: "#{location.protocol}//#{location.host}/admin/api/v1/admin/login"
    data: {
            admin_id: $("#admin-id").val(),
            admin_password: $("#admin-password").val()
            }

startAdminLogin = ->
  adminLlogin()
    .done (data) ->
      document.location = '/admin/top'
    .fail (response) ->
      apiErrorToast(response)
      
$ ->
  $('#admin-login').bind 'click', ->
    startAdminLogin()

  $('.enter-keydown-login').bind 'keydown', ->
    if event.keyCode is 13
      startAdminLogin()

