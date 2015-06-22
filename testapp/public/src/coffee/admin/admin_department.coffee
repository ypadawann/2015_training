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
      Materialize.toast("#{data.name}の登録に成功しました", 5000, 'alert-message')
      new_node = $( '<option />');
      new_node.val data.department_id
      new_node.text data.name
      $("#select-department").append(new_node)
      $("#register-department-name").val ''
    .fail (xhr,  status, error) ->
      if xhr.status is 400
        Materialize.toast('すでに登録されている部署です', 5000, 'alert-message')
      else
        Materialize.toast('部署の登録に失敗しました', 5000, 'alert-message')


$('#department-rename').bind 'click', ->
  oldName = $("#select-department option:selected").text()
  departmentRename()
    .done (data) ->
      Materialize.toast("#{oldName} を #{data.name} に変更しました", 5000, 'alert-message')
      $("#select-department option:selected").text data.name
      $("#new-department-name").val ''      
    .fail (xhr,  status, error) ->
      if xhr.status is 404
        Materialize.toast('部署が見つかりません', 5000, 'alert-message')
      else
        Materialize.toast('部署名の変更に失敗しました', 5000, 'alert-message')


startDepartmentDelete = ->
  departmentDelete()
    .done (data) ->
      Materialize.toast("#{data.name}を削除しました", 5000, 'alert-message')
      $("#select-department option:selected").remove()
    .fail (xhr,  status, error) ->
      if xhr.status is 400
        Materialize.toast('所属している人がいます', 5000, 'alert-message')
      if xhr.status is 404
        Materialize.toast('部署が見つかりません', 5000, 'alert-message')

$ ->
  $('#department-delete').leanModal({
    ready: ->
      $('#department-delete-agree').bind 'click', ->
        startDepartmentDelete()
    })

  $(document).ready ->
    $("#select-department").material_select()
