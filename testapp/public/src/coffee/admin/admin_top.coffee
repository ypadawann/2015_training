adminLogout = ->
  deferred = $.ajax
    async:     true
    type:      "PUT"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/logout"


$('.to-top').bind 'click', ->
  document.location = '/admin/top'

$('.to-admin-user').bind 'click', ->
  document.location = '/admin/user'

$('.to-admin-department').bind 'click', ->
  document.location = '/admin/department'

$('.to-admin-modify').bind 'click', ->
  document.location = '/admin/admin_modify'

$('.to-admin-register').bind 'click', ->
  document.location = '/admin/admin_register'

$('.admin-logout').bind 'click', ->
  adminLogout()
    .done (data) ->
      document.location = '/admin'
    .fail (xhr) ->
      apiErrorToast(xhr)
