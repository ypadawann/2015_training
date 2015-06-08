adminLlogin = ->
  deferred = $.ajax
    type: 'PUT'
    url: "#{location.protocol}//#{location.host}/admin/api/v1/admin/login"
    data: {
            admin_id: $("#admin_id").val(),
            admin_password: $("#admin_password").val()
            }


$('#admin-login').bind 'click', ->
  console.log location.host
  console.log location.hash
  adminLlogin()
    .done (data) ->
      document.location = '/admin/top'
    .fail (data) ->
      alert 'ログインに失敗しました'

