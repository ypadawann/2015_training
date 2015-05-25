user_select = ->
  console.log user_id = $("#user_id").text()
  deferred = $.ajax
    async:     true
    type:      "GET"
    url:       "/api/v1/users/#{user_id}"
    dataType:  "json"
    context:    this
  deferred.promise()

user_modify = ->
  console.log user_id = $('#user_id').text()
  console.log name = $('#name').val()
  console.log department = $('#department option:selected').text()
  console.log new_password = $('#new_password').val()
  console.log password = $('#password').val()
  deferred = $.ajax
    async:     true
    type:      "PUT"
    url:       "/api/v1/users/#{user_id}"
    data: { name: name, department: department, new_password: new_password, password: password }
    dataType:  "json"
    context:    this
  deferred.promise()

user_delete = ->
  user_id = $("#user_id").text()
  deferred = $.ajax
    async:     true
    type:      "DELETE"
    url:       "/api/v1/users/#{user_id}"
    dataType:  "json"
    context:    this
  deferred.promise()


$('#user_select').bind 'click', ->
  console.log 'user select'
  user_select()
    .done (data) ->
      console.log('ok')
      console.log(data.user_id)
      console.log(data.name)
      console.log(data.department)
      document.querySelector("#name").value = data.name
      ($('#department option').filter ->
        return $(this).text() is data.department).prop 'selected', true
    .fail (xhr,  status, error) ->
      console.log('ng')
      console.log(xhr)
      console.log(xhr.status)
      console.log(xhr.responseText)
      console.log(status)
      console.log(error)


$('#modify').bind 'click', ->
  console.log 'modifymodify'
  user_modify()
    .done (data)   ->
      console.log 'ok'
      console.log data.user_id
      console.log data.name
      console.log data.department
      $("#message").text 'Modify succeeded'
    .fail (xhr,  status, error) ->
      console.log('ng')
      console.log(xhr)
      console.log(xhr.status)
      console.log(xhr.responseText)
      console.log(status)
      console.log(error)


$('#delete').click ->
  console.log 'delete'
  user_delete()
    .done (data) ->
      console.log 'ok'
    .fail (xhr,  status, error) ->
      console.log('ng')
      console.log(xhr)
      console.log(xhr.status)
      console.log(xhr.responseText)
      console.log(status)
      console.log(error)
do ->    
user_select()
    .done (data) ->
      console.log('ok')
      console.log(data.user_id)
      console.log(data.name)
      console.log(data.department)
      document.querySelector("#name").value = data.name
      ($('#department option').filter ->
        return $(this).text() is data.department).prop 'selected', true
    .fail (xhr,  status, error) ->
      console.log('ng')
      console.log(xhr)
      console.log(xhr.status)
      console.log(xhr.responseText)
      console.log(status)
      console.log(error)

