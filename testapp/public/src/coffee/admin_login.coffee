admin_login = ->
  admin_id = $("#admin_id").val()
  admin_password = $("#admin_password").val()
  deferred = $.ajax
    type: 'PUT'
    url: './api/v1/admin/login'
    data: {
            admin_id: admin_id,
            admin_password: admin_password
            }


$('#admin-login').bind 'click', ->
  admin_login()
    .done (data) ->
      document.location = '/admin/top'
    .fail (data) ->
      alert 'エラーが発生しました'

