login = ->
  admin_name = prompt('IDを入力してください',"");
  password = prompt('パスワードを入力してください',"");
  deferred = $.ajax
    async: false
    type: 'PUT'
    url: '/api/v1/admin/login'
    data: {
            admin_name: admin_name,
            password: password
            }


do ->
  login()
    .done (data)->
      document.location = location.href
    .fail (data)->
      console.log 'ng'
      alert 'エラーが発生しました'
