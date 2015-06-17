departmentRegister = ->
  deferred = $.ajax
    type:      "POST"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/departments"
    data: 'name': $("#register-department-name").val()
    dataType:  "json"
    context:    this

departmentRename = ->
  department_id = $("#select-department option:selected").val()
  deferred = $.ajax
    type:      "PUT"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/departments/#{department_id}"
    data: 'name': $("#new-department-name").val()
    dataType: 'json'

departmentDelete = ->
  department_id = $("#select-department option:selected").val()
  deferred = $.ajax
    type:      "DELETE"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/departments/#{department_id}"
    dataType: 'json'

$('#department-register').bind 'click', ->
  departmentRegister()
    .done (data) ->
      alert "#{data.name}の登録に成功しました"
      location.reload()
    .fail (xhr,  status, error) ->
      if xhr.status is 400
        #alert 'すでに登録されている部署です'
        Materialize.toast('すでに登録されている部署です', 5000, 'alert-message')
      else
        Materialize.toast('部署の登録に失敗しました', 5000, 'alert-message')


$('#department-rename').bind 'click', ->
  oldName = $("#select-department option:selected").text()
  console.log 'rename'
  departmentRename()
    .done (data) ->
      alert "#{oldName} を #{data.name} に変更しました"
      location.reload()
    .fail (xhr,  status, error) ->
      if xhr.status is 404
        #alert '部署が見つかりません'
        Materialize.toast('部署が見つかりません', 5000, 'alert-message')
      else
        #alert '部署名の変更に失敗しました'
        Materialize.toast('部署名の変更に失敗しました', 5000, 'alert-message')


$('#department-delete').click ->
  if !window.confirm '本当に部署を削除しますか？'
  else
    departmentDelete()
      .done (data) ->
        alert '部署を削除しました'
        location.reload()
      .fail (xhr,  status, error) ->
        if xhr.status is 400
          #alert '所属している人がいます'
          Materialize.toast('所属している人がいます', 5000, 'alert-message')
        if xhr.status is 404
          #alert '部署が見つかりません'
          Materialize.toast('部署が見つかりません', 5000, 'alert-message')


$(document).ready ->
 $("#select-department").material_select()
