# API仕様

api/v1/..

parametersを受け取り、resultsをJSONで返す。

* POST users
    * ユーザ登録
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
    * parameters
        * name: string
        * department: string
        * password: string
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* GET users/:user_id
    * ユーザ情報の取得
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* DELETE users/:user_id
    * ユーザ削除
    * parameters
    * results
    * errors
        * 404: ユーザが見つからない

* PUT users/:user_id/login
    * ログイン
    * parameters
        * password: string
    * results
    * errors
        * 403: 認証に失敗した

* PUT users/:user_id/logout
    * ログアウト
    * parameters
    * results
    * errors
        * 403: 認証に失敗した

* POST users/:user_id/attend
    * 出勤
    * results
        * user_id: integer
        * name: string
        * department: string
        * date: date
        * attendance: time
    * errors
        * 403: 認証に失敗した

* POST users/:user_id/leave
    * 退勤
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
    * parameters
        * array of
            * day: integer
            * attendace: time
            * leaving: time
    * results
        * user_id: integer
        * name: string
        * department: string
    * errors
        * 403: 認証に失敗した

* POST departments
    * 部署登録
    * parameters
        * name: string
    * results
        * name: string
    * errors
        * 400: すでに登録されている

* PUT departments/:department_id
    * 部署情報の更新
    * parameters
        * name: string
    * results
        * name: string
    * errors
        * 404: 部署が見つからない

* DELETE departments/:department_id
    * 部署削除
    * parameters
    * results
    * errors
        * 400: 所属している人がいる
        * 404: 部署が見つからない
