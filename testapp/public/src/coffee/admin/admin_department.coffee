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


startDepartmentRegister = ->
  departmentRegister()
    .done (data) ->
      Materialize.toast("#{data.name}の登録に成功しました", 5000, 'alert-message')
      new_node = $( '<option />');
      new_node.val data.department_id
      new_node.text data.name
      $("#select-department").append(new_node)
      $("#register-department-name").val ''
    .fail (xhr,  status, error) ->
      apiErrorToast(xhr)

startDepartmentRename = ->
  oldName = $("#select-department option:selected").text()
  departmentRename()
    .done (data) ->
      $("#select-department option:selected").text data.name
      $("#new-department-name").val ''
      Materialize.toast("#{oldName} を #{data.name} に変更しました", 5000, 'alert-message')
    .fail (xhr, status, error) ->
      apiErrorToast(xhr)

startDepartmentDelete = ->
  departmentDelete()
    .done (data) ->
      Materialize.toast("#{data.name}を削除しました", 5000, 'alert-message')
      $("#select-department option:selected").remove()
    .fail (xhr,  status, error) ->
      apiErrorToast(xhr)

$('#department-register').bind 'click', ->
  startDepartmentRegister()

$('#department-rename').bind 'click', ->
  startDepartmentRename()


$ ->
  $("#select-department").material_select()
  
  $('#department-delete').leanModal({
    ready: ->
      $('#department-delete-agree').bind 'click', ->
        startDepartmentDelete()
    })


  $('.enter-for-regist-department').bind 'keydown', ->
    if event.keyCode is 13
      startDepartmentRegister()

  $('.enter-for-rename-department').bind 'keydown', ->
    if event.keyCode is 13
      startDepartmentRename()
