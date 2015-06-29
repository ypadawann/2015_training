 # language:ja
機能: ユーザ登録画面
  シナリオ: 有効なユーザ登録
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 以下を入力し
      | 社員番号(#user_id)    | 1000        |
      | 名前(#name)           | あか さたな |
      | 入社年(#enter_year)   | 2014        |
      | 入社月(#enter_month)  | 4           |
      | 入社日(#enter_day)    | 1           |
      | パスワード(#password) | abc         |
    かつ 所属(#department) 欄から RDD を選択し
    かつ 送信(#register) ボタンをクリックした

    ならば ユーザページ(/userpage) 画面に遷移し
    かつ HTTPステータスコードは 200 であり
    かつ 社員番号(#current-user-id) 欄に 1000 が表示される

  シナリオ: 同じ社員番号のユーザが存在するときユーザ登録が失敗する
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 以下を入力し
      | 社員番号(#user_id)    | 1000        |
      | 名前(#name)           | あか さたな |
      | 入社年(#enter_year)   | 2014        |
      | 入社月(#enter_month)  | 4           |
      | 入社日(#enter_day)    | 1           |
      | パスワード(#password) | abc         |
    かつ 所属(#department) 欄から RDD を選択し
    かつ 送信(#register) ボタンをクリックした

    ならば 画面遷移せず (非同期)
    かつ 社員番号 を含むアラートが表示される

  シナリオ: 社員番号が空のときユーザ登録が失敗する
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 以下を入力し
      | 名前(#name)           | あか さたな |
      | 入社年(#enter_year)   | 2014        |
      | 入社月(#enter_month)  | 4           |
      | 入社日(#enter_day)    | 1           |
      | パスワード(#password) | abc         |
    かつ 所属(#department) 欄から RDD を選択し
    かつ 送信(#register) ボタンをクリックした

    ならば 画面遷移せず (非同期)
    かつ 社員番号 を含むアラートが表示される

  シナリオ: 社員番号がマイナスのときユーザ登録が失敗する
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 以下を入力し
      | 社員番号(#user_id)    | -1000       |
      | 名前(#name)           | あか さたな |
      | 入社年(#enter_year)   | 2014        |
      | 入社月(#enter_month)  | 4           |
      | 入社日(#enter_day)    | 1           |
      | パスワード(#password) | abc         |
    かつ 所属(#department) 欄から RDD を選択し
    かつ 送信(#register) ボタンをクリックした

    ならば 画面遷移せず (非同期)
    かつ 社員番号 を含むアラートが表示される

  シナリオ: 名前が空のときユーザ登録が失敗する
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 以下を入力し
      | 社員番号(#user_id)    | 1000        |
      | 入社年(#enter_year)   | 2014        |
      | 入社月(#enter_month)  | 4           |
      | 入社日(#enter_day)    | 1           |
      | パスワード(#password) | abc         |
    かつ 所属(#department) 欄から RDD を選択し
    かつ 送信(#register) ボタンをクリックした

    ならば 画面遷移せず (非同期)
    かつ 名前 を含むアラートが表示される

  シナリオ: 部署が選択されていないときユーザ登録が失敗する
    もし ユーザ登録(/register) 画面にアクセスし
    かつ 以下を入力し
      | 社員番号(#user_id)    | 1000        |
      | 名前(#name)           | あか さたな |
      | 入社年(#enter_year)   | 2014        |
      | 入社月(#enter_month)  | 4           |
      | 入社日(#enter_day)    | 1           |
      | パスワード(#password) | abc         |
    かつ 送信(#register) ボタンをクリックした

    ならば 画面遷移せず (非同期)
    かつ 所属 を含むアラートが表示される

  シナリオ: 入社年月日が空のときユーザ登録が失敗する
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 以下を入力し
      | 社員番号(#user_id)    | 1000        |
      | 名前(#name)           | あか さたな |
      | 入社月(#enter_month)  | 4           |
      | 入社日(#enter_day)    | 1           |
      | パスワード(#password) | abc         |
    かつ 所属(#department) 欄から RDD を選択し
    かつ 送信(#register) ボタンをクリックした

    ならば 画面遷移せず (非同期)
    かつ 入社年月日 を含むアラートが表示される

  シナリオ: パスワードが空のときユーザ登録が失敗する
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 以下を入力し
      | 社員番号(#user_id)    | 1000        |
      | 名前(#name)           | あか さたな |
      | 入社年(#enter_year)   | 2014        |
      | 入社月(#enter_month)  | 4           |
      | 入社日(#enter_day)    | 1           |
    かつ 所属(#department) 欄から RDD を選択し
    かつ 送信(#register) ボタンをクリックした

    ならば 画面遷移せず (非同期)
    かつ パスワード を含むアラートが表示される

  シナリオ: ユーザ登録の入力はHTMLエスケープされる
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 社員番号(#user_id) 欄に 1000 を入力し
    かつ 名前(#name) 欄に <p>&</p> を入力し
    かつ 所属(#department) 欄から RDD を選択し
    かつ 入社年(#enter_year) 欄に 2014 を入力し
    かつ 入社月(#enter_month) 欄に 4 を入力し
    かつ 入社日(#enter_day) 欄に 1 を入力し
    かつ パスワード(#password) 欄に abc を入力し
    かつ 送信(#register) ボタンをクリックした

    ならば ユーザページ(/userpage) 画面に遷移し
    かつ HTTPステータスコードは 200 であり
    かつ 名前(#current-user-name) 欄に <p>&</p> が表示される
