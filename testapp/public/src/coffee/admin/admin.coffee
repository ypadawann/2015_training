require 'es5-shim'
require './admin_top'
require './admin_user'
require './admin_department'
require './admin_modify'
require './admin_register'
require './admin_login'

window.apiErrorToast = (response) ->
  try
    Materialize.toast(JSON.parse(response.responseText).error, 5000, 'alert-message')
  catch error
    Materialize.toast('エラーが発生しました', 5000, 'alert-message') 
