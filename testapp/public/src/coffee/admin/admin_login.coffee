adminLlogin = ->
  deferred = $.ajax
    type: 'PUT'
    url: "#{location.protocol}//#{location.host}/admin/api/v1/admin/login"
    data: {
            admin_id: $("#admin-id").val(),
            admin_password: $("#admin-password").val()
            }


$('#admin-login').bind 'click', ->
  adminLlogin()
    .done (data) ->
      document.location = '/admin/top'
    .fail (data) ->
      alert 'ログインに失敗しました'
