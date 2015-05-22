## API仕様

URIは api/v1/[リソース名]

parametersを受け取り、resultsをJSONで返す。

* GET users
    * ユーザ一覧の取得
    * headers
    * parameters
    * results
        * users: array of
           * user_id: integer
           * name: string
           * department: string
    * errors

* POST users
    * ユーザ登録
    * headers
    * parameters
        * user_id: integer
        * name: string
        * department: string
        * password: string
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 400: 登録に失敗した

* PUT users/:user_id
    * ユーザ情報の変更
    * headers
    * parameters
        * (optional) name: string
        * (optional) department: string
        * (optional) new_password: string
        * password: string
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* GET users/:user_id
    * ユーザ情報の取得
    * headers
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* DELETE users/:user_id
    * ユーザ削除
    * headers
    * parameters
    * results
    * errors
        * 404: ユーザが見つからない

* PUT users/:user_id/login
    * ログイン
    * headers
    * parameters
        * password: string
    * results
    * errors
        * 403: 認証に失敗した

* PUT users/:user_id/logout
    * ログアウト
    * headers
    * parameters
    * results
    * errors
        * 403: 認証に失敗した

* POST users/:user_id/attend
    * 出勤
    * headers
    * results
        * user_id: integer
        * name: string
        * department: string
        * date: date
        * attendance: time
    * errors
        * 400: すでに出勤している
        * 403: 認証に失敗した

* POST users/:user_id/leave
    * 退勤
    * headers
    * results
        * user_id: integer
        * name: string
        * department: string
        * date: date
        * leaving: time
    * errors
        * 403: 認証に失敗した
        * 404: 出勤していない

* PUT users/:user_id/attend/:date
    * 出勤の更新
    * headers
    * parameters
        * attendance: time
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* PUT users/:user_id/leave/:date
    * 退勤の更新
    * headers
    * parameters
        * leaving: time
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* PUT users/:user_id/attend-leave/:year-month
    * 月の出退勤の一括更新
    * headers
    * parameters
        * data: array of
            * day: integer
            * attendace: time
            * leaving: time
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* GET departments
    * 部署一覧の取得
    * headers
    * parameters
    * results
        * departments: array of
            * department_id: integer
            * name: string
    * results

* POST departments
    * 部署登録
    * headers
    * parameters
        * name: string
    * results
        * name: string
    * errors
        * 400: すでに登録されている

* GET departments/:department_id
    * 部署情報の取得
    * headers
    * parameters
    * results
        * name: string
    * errors
        * 404: 部署が見つからない

* PUT departments/:department_id
    * 部署情報の更新
    * headers
    * parameters
        * name: string
    * results
        * name: string
    * errors
        * 404: 部署が見つからない

* DELETE departments/:department_id
    * 部署削除
    * headers
    * parameters
    * results
    * errors
        * 400: 所属している人がいる
        * 404: 部署が見つからない

## APIを追加するには

api/v1/myclass.rb に

```
module API
  module V1
    class MyClass
    ..
    end
  end
end
```

のようにAPIを書いたあと、api/v1/base.rbに以下の2行を追記する。

```ruby:api/v1/base.rb
require './api/v1/myclass.rb'
mount MyClass
```
