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
        * enter_date: date
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

* GET users/:user_id/paid_vacation
    * 有給残数取得
    * headers
    * parameters
    * results
        * paid_vacation_num: float
    * errors
        * 403: 認証に失敗しました

* POST users/:user_id/paid_vacation
    * 有給一括登録
    * headers
    * parameters
        * full_vacation array of
            * date: date
        * half_vacation array of
            * date: date
    * results
    * errors
        * 403: 認証に失敗しました

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

* PUT users/:user_id/attend-leave/:year/:month
    * 月の出退勤の一括更新
    * headers
    * parameters
        * data: array of
            * day: integer
            * attendace: time
            * leaving: time
            * prearranged_holiday: date
            * paid_vacation: string
            * holiday_acquisition: date
            * etc: string
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* GET users/:user_id/attend-leave/:year/:month
    * 月の出退勤情報一括取得
    * headers
    * parameters
    * results
        * data: array of
            * day: integer
            * weekday: string
            * isholiday: boolean
            * attendace: time
            * leaving: time
            * midnight_work: string
            * holiday_shift: string
            * prearranged_holiday: date
            * paid_vacation: string
            * holiday_acquisition: date
            * etc: string
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

* POST admin
    * 管理者登録
    * header
    * parameters
        * admin_id: string
	* admin_password: string
    * results
    * error

* PUT admin/:admin_id/
    * 管理者情報取得
    * headers
    * parameters
    * results
    * errors
        * 403: 認証に失敗した

* DELETE admin/:admin_id/
    * 管理者削除
    * headers
    * parameters
    * results
    * errors
        * 403: 認証に失敗した

* PUT admin/:admin_id/
    * 管理者情報更新
    * headers
    * parameters
	* admin_new_password: string
	* admin_password: string
    * results
    * errors
        * 403: 認証に失敗した

* PUT admin/login
    * 管理者ログイン
    * headers
    * parameters
	* admin_id: string
    * results
    * errors
        * 403: 認証に失敗した

* PUT admin/logout
    * 管理者ログアウト
    * headers
    * parameters
    * results
    * errors
        * 403: 認証に失敗した


* GET admin/users/:user_id
    * 管理者によるユーザ情報取得
    * headers
    * parameters
    * results
        * user_id: integer
        * user_name: string
        * department: string
    * errors

* PUT admin/users/:user_id
    * 管理者によるユーザ情報変更
    * headers
    * parameters
        * (optional) user_name: string
        * (optional) department: string
        * (optional) user_new_password: string
    * results
        * user_id: integer
        * user_name: string
        * department: string
    * errors


* DELETE admin/users/:user_id
    * 管理者によるユーザ削除
    * headers
    * parameters
    * results
    * errors
        * 404: ユーザが見つからない





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
