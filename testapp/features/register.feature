 # language:ja
機能: ユーザ登録画面
  シナリオ: 有効なユーザ登録
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 社員番号(#user_id) 欄に 1000 を入力し
    かつ 名前(#name) 欄に あか さたな を入力し
    かつ 所属(#department) 欄から RDD を選択し
    かつ 入社年(#enter_year) 欄に 2014 を入力し
    かつ 入社月(#enter_month) 欄に 4 を入力し
    かつ 入社日(#enter_day) 欄に 1 を入力し
    かつ パスワード(#password) 欄に abc を入力し
    かつ 送信(#register) ボタンをクリックした

    ならば ユーザページ(/userpage) 画面に遷移し
    かつ HTTPステータスコードは 200 であり
    かつ 社員番号(#user-id) 欄に 1000 が表示される

  シナリオ: 同じ社員番号のユーザが存在するときのユーザ登録
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 社員番号(#user_id) 欄に 1000 を入力し
    かつ 名前(#name) 欄に def を入力し
    かつ 所属(#department) 欄から RDD を選択し
    かつ 入社年(#enter_year) 欄に 2015 を入力し
    かつ 入社月(#enter_month) 欄に 4 を入力し
    かつ 入社日(#enter_day) 欄に 1 を入力し
    かつ パスワード(#password) 欄に def を入力し
    かつ 送信(#register) ボタンをクリックした

    ならば ユーザ登録(/register) 画面に遷移し
    かつ 社員番号(#user_id) 欄に 1000 が入力される

  シナリオ: 長い名前のユーザの登録
    前提: 部署 RDD が存在する

    もし ユーザ登録(/register) 画面にアクセスし
    かつ 社員番号(#user_id) 欄に 1000 を入力し
    かつ 名前(#name) 欄に abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz を入力し
    かつ 所属(#department) 欄から RDD を選択し
    かつ 入社年(#enter_year) 欄に 2014 を入力し
    かつ 入社月(#enter_month) 欄に 4 を入力し
    かつ 入社日(#enter_day) 欄に 1 を入力し
    かつ パスワード(#password) 欄に abc を入力し
    かつ 送信(#register) ボタンをクリックした

    ならば ユーザ登録(/register) 画面に遷移し
    かつ 社員番号(#user_id) 欄に 1000 が入力される

  シナリオ: 名前にHTMLタグを含むユーザの登録
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
    かつ 名前(#user-name) 欄に <p>&</p>さん が表示される
