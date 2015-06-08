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
        alert 'すでに登録されている部署です'
      else
        alert '部署の登録に失敗しました'

$('#department-rename').bind 'click', ->
  oldName = $("#select-department option:selected").text()
  console.log 'rename'
  departmentRename()
    .done (data) ->
      alert "#{oldName} を #{data.name} に変更しました"
      location.reload()
    .fail (xhr,  status, error) ->
      if xhr.status is 404
        alert '部署が見つかりません'
      else
        alert '部署名の変更に失敗しました'

$('#department-delete').click ->
  if !window.confirm '本当に部署を削除しますか？'
  else
    departmentDelete()
      .done (data) ->
        alert '部署を削除しました'
        location.reload()
      .fail (xhr,  status, error) ->
        if xhr.status is 400
          alert '所属している人がいます'
        if xhr.status is 404
          alert '部署が見つかりません'

