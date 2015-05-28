logout = ->
  deferred = $.ajax
    async:     true
    type:      "PUT"
    url: "#{location.protocol}//#{location.host}/api/v1/admin/logout"

console.log (location.host)
console.log location.protocol

$('#admin-user').bind 'click', ->
  document.location = '/admin/user'

$('#admin-department').bind 'click', ->
  document.location = '/admin/department'

$('#admin-logout').bind 'click', ->
  logout()
    .done (data) ->
      document.location = '/'
    .fail (data) ->
      alert 'エラーが発生しました'
