department_register = ->
  console.log department_name = $("#register-name").val()
  deferred = $.ajax
    type:      "POST"
    url:       "./api/v1/departments"
    data: 'name': department_name
    dataType:  "json"
    context:    this

department_rename = ->
  console.log department_id = $("#department-rename-id option:selected").val()
  console.log new_department_name = $("#new-department-name").val()
  deferred = $.ajax
    type:      "PUT"
    url:       "./api/v1/departments/#{department_id}"
    data: 'name': new_department_name
    dataType: 'json'

department_delete = ->
  department_id = $("#department-rename-id option:selected").val()
  deferred = $.ajax
    type:      "DELETE"
    url:       "./api/v1/departments/#{department_id}"
    dataType: 'json'

$('#department-register').bind 'click', ->
  department_register()
    .done (data) ->
      console.log 'department register'
      location.reload()
    .fail (xhr,  status, error) ->
      console.log 'error in department register'
      
$('#department-rename').bind 'click', ->
  department_rename()
    .done (datva)   ->
      console.log 'department rename'
      location.reload()
    .fail (xhr,  status, error) ->
      console.log 'error in department rename'
###
      if xhr.status is 403
        $("#message").text '認証に失敗しました'
      else
        $("#message").text 'エラーが発生しました'
###
$('#department-delete').click ->
  if !window.confirm '本当に部署を削除しますか？'
    console.log 'cancel delete'
    # $("#message").text '部署削除をキャンセルしました'
  else
    department_delete()
      .done (data) ->
        alert '部署を削除しました'
        location.reload()
      .fail (xhr,  status, error) ->
        console.log 'error in department delete'
        #$("#message").text 'エラーが発生しました'

