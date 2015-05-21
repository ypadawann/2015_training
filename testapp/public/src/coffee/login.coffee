$ ->
  $('#register').click ->
    id = $('#no').val()
    name = $('#name').val()
    department = $('#department option:selected').text()
    password = $('#pass').val()
    request = $.ajax(
      type: 'post'
      url: 'api/v1/users'
      data:
        'id': id
        'name': name
        'department': department
        'password': password
      success: (msg) ->
        `var request`
        request = $.ajax(
          type: 'post'
          url: '/login'
          data:
            'no': id
            'password': password
          success: (msg) ->
            document.location = '/'
            return
        )
        return
      error: ->
        alert 'エラー'
        document.location = '/register'
        return
    )
    return
  return
