login = ->
  admin_id = prompt('IDを入力してください', '')
  password = prompt('パスワードを入力してください', '')
  console.log typeof parseInt(admin_id)
  console.log typeof password
  console.log parseInt(admin_id)
  console.log password
  deferred = $.ajax
    async: false
    type: 'PUT'
    url: "#{location.protocol}//#{location.host}/api/v1/admin/login"
    data: {
            admin_id: parseInt(admin_id),
            admin_password: password
            }


do ->
  login()
    .done (data)->
      document.location = location.href
    .fail (data)->
      console.log 'login ng'
      alert 'エラーが発生しました'
