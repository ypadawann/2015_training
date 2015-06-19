# language:ja
機能: ログイン処理
  ログイン処理が正しく行われているかの動作確認

  シナリオ: ログイン処理(成功時)
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2015-04-01 が存在する

    もし トップページ(/) にアクセスし、
    かつ 社員番号(#user_id) に 1111 を入力し、
    かつ pass(#password) に 12345 を入力し、
    かつ ログインボタン(#login) をクリックした

    ならば ユーザ名(#user-name) が testさん である
    かつ ユーザページ(/userpage) にアクセスする

  シナリオ: 存在しないユーザでのログイン処理(失敗時)
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2015-04-01 が存在する

    もし トップページ(/) にアクセスし、
    かつ 社員番号(#user_id) に 2222 を入力し、
    かつ pass(#password) に 12345 を入力し、
    かつ ログインボタン(#login) をクリックした

   ならば エラーメッセージ(#error_message) が 社員番号又はパスワードが違います である (非同期)

  シナリオ: パスワードが違う場合のログイン処理(失敗時)
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2015-04-01 が存在する

    もし トップページ(/) にアクセスし、
    かつ 社員番号(#user_id) に 1111 を入力し、
    かつ pass(#password) に 54321 を入力し、
    かつ ログインボタン(#login) をクリックした

    ならば エラーメッセージ(#error_message) が 社員番号又はパスワードが違います である (非同期)
