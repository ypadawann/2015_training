_ = require 'lodash'

userSelect = ->
  userId = $("#user-id").val()
  deferred = $.ajax
    async:     true
    type:      "GET"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    dataType:  "json"
    context:    this

userModify = ->
  userId = $('#user-id').val()
  deferred = $.ajax
    async:     true
    type:      "PUT"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    data:
      'name': $('#user-name').val()
      'department': $('#select-department option:selected').text()
      'new_password': $('#user-new-password').val()
    dataType:  "json"
    context:    this

userDelete = ->
  userId = $("#user-id").val()
  deferred = $.ajax
    async:     true
    type:      "DELETE"
    url:       "#{location.protocol}//#{location.host}/admin/api/v1/admin/users/#{userId}"
    dataType:  "json"
    context:    this

getUserList = ->
  deferred = $.ajax
    type: 'GET'
    url: "//#{location.host}/admin/api/v1/admin/users/all"
    dataType: 'json'

startUserSelect = ->
  userSelect()
    .done (data) ->
      $("#user-name").focus()
      $("#user-name").val data.name
      ($('#select-department option').filter ->
        $(this).text() is data.department).prop 'selected', true
    .fail (xhr,  textStatus, errorThrown) ->
      apiErrorToast(xhr)

startUserDelete = ->
  userDelete()
    .done (data) ->
      Materialize.toast('アカウントを削除しました', 5000, 'alert-message')
      $('#user-id').val ''
      $('#user-name').val ''
      ($('#select-department option').filter ->
        $(this).text() is '部署を選択' ).prop 'selected', true
      $('#user-new-password').val ''
      $('#confirm-user-new-password').val ''
    .fail (xhr,  status, error) ->
      apiErrorToast(xhr)

createUsersListModal = (userList) ->
  $('#modal__users-list').empty()
  (_.range(0, userList.length)).forEach (i) ->
    collectionItem = "#{userList[i].user_id}: #{userList[i].name}"
    newNode =
      $( "<a />", { href: "#!", id: "modal__user-select-target#{i}", class: "collection-item modal-action modal-close modal__user-select-target" } )
    newNode.text collectionItem
    $('#modal__users-list').append(newNode)

startSearchUser = ->
  searchWord = $('#modal__search__input').val()
  userList = $('.modal__user-select-target')
  (_.range(0, userList.length)).forEach (i) ->
    if (userList[i].text.toLowerCase()).indexOf(searchWord.toLowerCase()) is -1
      userList[i].style.display="none"
    else
      userList[i].style.display=""


$ ->
  $('#user-select').bind 'click', ->
    event.preventDefault()
    startUserSelect()


  $('#user-modify').bind 'click', ->
    if $('#user-new-password').val() isnt $('#confirm-user-new-password').val()
      Materialize.toast('確認パスワードが違います', 5000, 'alert-message')
    else
      userModify()
        .done (data)   ->
          Materialize.toast('ユーザ情報を変更しました', 5000, 'alert-message')
          $('#user-new-password').val ''
          $('#confirm-user-new-password').val ''
        .fail (xhr,  status, error) ->
          apiErrorToast(xhr)

  $('#get-users-list').bind 'click', ->
    getUserList()
      .done (data) ->
        $('#modal__search__input').val ''
        createUsersListModal(data.users)
        $('.modal__user-select-target').bind 'click', ->
          $('#user-id').focus()
          $('#user-id').val $(this).text().split(": ")[0]
          startUserSelect()        
      .fail (xhr) ->
        apiErrorToast(xhr)
      .always () ->
        $('#modal__user-list').openModal()
        $('#modal__search__input').focus()

  $('#user-delete').bind 'click', ->
    $('#modal__user-delete__user-id').text "ID: #{$('#user-id').val()}"
    $('#modal__user-delete__user-name').text "名前: #{$('#user-name').val()}"
    $('#modal__user-delete').openModal();
    $('#user-delete-agree').bind 'click', ->
      startUserDelete()

  $('#modal__search__start-button').bind 'click', ->
    event.preventDefault()
    startSearchUser()

