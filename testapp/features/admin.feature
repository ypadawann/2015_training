# language: ja

機能: 管理者機能
  サンプル用のテストアプリケーションの動作確認

  シナリオ: ログイン画面を表示
    もし "ログイン画面(/admin)" にアクセス

    ならば "ログインボタン(#admin-login)" が存在

  シナリオ: ログイン処理（マウスクリック）
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "ログアウトボタン(#admin-logout)" が存在

  シナリオ: ログイン処理（エンターキー）
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "パスワード欄(#admin-password)" で "エンターキー(Enter)" をキー入力
    ならば "ログアウトボタン(#admin-logout)" が存在

  シナリオ: ログイン処理（失敗）
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "passwordpssword" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "アラート(.alert-message)" に "ログインに失敗しました" と表示


  シナリオ: ログイン後にページ遷移
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
   
    もし "ログインボタン(#admin-login)" をクリック
    ならば "ログアウトボタン(#admin-logout)" が存在

    もし "ユーザ情報管理(#admin-user)" をクリック
    ならば "ユーザ情報変更ボタン(#user-modify)" が存在

    もし "トップページ(/admin/top)" にアクセス
    かつ "部署管理(#admin-department)" をクリック
    ならば "部署登録ボタン(#department-register)" が存在

  シナリオ: ユーザ情報変更
    前提 管理者にID "admin"、パスワード "password" が存在
    前提 部署 "Kure" が存在
    前提 ユーザにID "23"、名前 "Haruna"、部署 "Navy"、パスワード "userpassword"、入社日 "1915-04-19" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力

    もし "ログインボタン(#admin-login)" をクリック
    ならば "ログアウトボタン(#admin-logout)" が存在

    もし "ユーザ情報管理(#admin-user)" をクリック
    かつ "ユーザID(#user-id)" に "23" を入力
    かつ "選択ボタン(#user-select)" をクリック
    ならば "ユーザ名(#user-name)" に "Haruna" と表示
    かつ "部署(#select-department)" で "Navy" が選択

    もし "ユーザ名(#user-name)" に "榛名" を入力
    かつ "部署(#select-department)" で "Kure" を選択
    かつ "変更ボタン(#user-modify)" をクリック
    ならば "アラート(.alert-message)" に "ユーザ情報を変更しました" と表示
    
    もし "1" 秒待機
    かつ "ユーザID(#user-id)" に "23" を入力
    かつ "選択ボタン(#user-select)" をクリック
    ならば "ユーザ名(#user-name)" に "榛名" と表示
    かつ "部署(#select-department)" で "Kure" が選択

    もし "新しいパスワード(#user-new-password)" に "newpassword" を入力
    かつ "確認パスワード(#confirm-user-new-password)" に "wrongpassword" を入力
    かつ "変更ボタン(#user-modify)" をクリック
    ならば "アラート(.alert-message)" に "パスワードが違います" と表示

    もし "確認パスワード(#confirm-user-new-password)" に "newpassword" を入力
    かつ "変更ボタン(#user-modify)" をクリック
    ならば "1" 秒待機
    かつ "アラート(.alert-message)" に "ユーザ情報を変更しました" と表示
    かつ "新しいパスワード(#user-new-password)" に "" と表示
    かつ "確認パスワード(#confirm-user-new-password)" に "" と表示

    もし "ユーザログイン画面(/)" にアクセス
    かつ "ユーザID(#user_id)" に "23" を入力
    かつ "パスワード(#password)" に "newpassword" を入力
    かつ "ログインボタン(#login)" をクリック
    ならば "ログアウトボタン(#logout)" が存在

  シナリオ: ユーザを削除
    前提 管理者にID "admin"、パスワード "password" が存在
    前提 ユーザにID "23"、名前 "Haruna"、部署 "Navy"、パスワード "userpassword"、入社日 "1915-04-19" が存在

    もし "初期化ページ(/test/init-data)" にアクセス

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック

    もし "ユーザ情報管理(#admin-user)" をクリック
    ならば "ユーザID(#user-id)" に "23" を入力
    かつ "選択ボタン(#user-select)" をクリック

    もし "1" 秒待機
    ならば "削除ボタン(#user-delete)" をクリック

    もし "1" 秒待機
    もし "モーダル(#modal)" が存在
    かつ "(#modal-h4)" に "確認" と表示
    かつ "(#modal-p)" に "本当にユーザを削除しますか？" と表示
    かつ "はい(#user-delete-agree)" が存在
    かつ "はい(#user-delete-agree)" に "はい" と表示
    かつ "いいえ(#user-delete-disagree)" が存在
    ならば "はい(#user-delete-agree)" をクリック

    もし "アラート(.alert-message)" に "アカウントを削除しました" と表示
    かつ "ユーザID(#user-id)" に "" と表示
    かつ "ユーザ名(#user-name)" に "" と表示
    かつ "部署名(#select-department)" で "部署を選択" が選択
    かつ "新しいパスワード(#user-new-password)" に "" と表示
    かつ "確認パスワード(#confirm-user-new-password)" に "" と表示

  シナリオ: 部署管理
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック    


    もし "部署管理(#admin-department)" をクリック
    かつ "登録する部署名(#register-department-name)" に "横須賀鎮守府" を入力
    かつ "選択ボタン(#department-register)" をクリック
    ならば "アラート(.alert-message)" に "横須賀鎮守府の登録に成功しました" と表示

    もし "1" 秒待機
    かつ "登録する部署名(#register-department-name)" に "横須賀鎮守府" を入力
    かつ "選択ボタン(#department-register)" をクリック
    ならば "アラート(.alert-message)" に "すでに登録されている部署です" と表示
    
    もし "1" 秒待機
    かつ "部署(#select-department)" で "横須賀鎮守府" を選択
    かつ "新しい部署名(#new-department-name)" に "ブラック鎮守府" を入力
    ならば "部署名変更(#department-rename)" をクリック

    もし "1" 秒待機
    かつ "部署(#select-department)" で "ブラック鎮守府" を選択
    かつ "部署削除(#department-delete)" をクリック
    ならば "モーダル(#modal)" が存在
    かつ "メッセージ(#modal-p)" に "本当に部署を削除しますか？" と表示

    もし "いいえ(#department-delete-disagree)" をクリック
    かつ "1" 秒待機
    ならば "ページ(body)" に "モーダル(#modal)" が存在しない

    もし "部署削除(#department-delete)" をクリック
    かつ "はい(#department-delete-agree)" をクリック
    ならば "アラート(.alert-message)" に "ブラック鎮守府を削除しました" と表示
    かつ "部署(#select-department)" に "選択肢(ブラック鎮守府)" が存在しない
    

  シナリオ: 管理者情報管理（パスワード変更）
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック


    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    かつ "管理者情報管理(#admin-admin)" をクリック
    ならば "管理者ID(#admin-id)" に "admin" と表示

    もし "新しいパスワード(#admin-new-password)" に "adminnewpassword" を入力
    かつ "確認パスワード(#confirm-admin-new-password)" に "wrongadminnewpassword" を入力
    かつ "変更ボタン(#admin-modify)" をクリック
    ならば "アラート(.alert-message)" に "確認パスワードが違います" と表示
    
    もし "確認パスワード(#confirm-admin-new-password)" に "adminnewpassword" を入力
    かつ "変更ボタン(#admin-modify)" をクリック
    ならば "アラート(.alert-message)" に "認証に失敗しました" と表示

    もし "パスワード(#admin-password)" に "wrongpassword" を入力
    かつ "変更ボタン(#admin-modify)" をクリック
    ならば "アラート(.alert-message)" に "認証に失敗しました" と表示

    もし "パスワード(#admin-password)" に "password" を入力
    かつ "変更ボタン(#admin-modify)" をクリック
    ならば "1" 秒待機
    かつ "新しいパスワード(#admin-new-password)" に "" と表示

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "adminnewpassword" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "ログアウトボタン(#admin-logout)" が存在

  シナリオ: 管理者登録
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック

    かつ "管理者情報管理(#to-admin-register)" をクリック
    ならば "管理者登録ボタン(#admin-register)" が存在

    もし "管理者ID(#admin-id)" に "root" を入力
    かつ "管理者パスワード(#admin-password)" に "rootpassword" を入力
    かつ "確認パスワード(#confirm-admin-password)" に "wrongrootpassword" を入力
    かつ "管理者登録ボタン(#admin-register)" をクリック
    ならば "アラート(.alert-message)" に "確認パスワードが違います" と表示

    もし "確認パスワード(#confirm-admin-password)" に "rootpassword" を入力
    かつ "管理者登録ボタン(#admin-register)" をクリック
    ならば "アラート(.alert-message)" に "登録に成功しました" と表示
    かつ "管理者ID(#admin-id)" に "" と表示
    かつ "パスワード(#admin-password)" に "" と表示
    かつ "確認パスワード(#confirm-admin-password)" に "" と表示

    もし "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "secondpassword" を入力
    かつ "確認パスワード(#confirm-admin-password)" に "secondpassword" を入力
    かつ "管理者登録ボタン(#admin-register)" をクリック
    ならば "アラート(.alert-message)" に "エラーが発生しました" と表示

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "root" を入力
    かつ "管理者パスワード(#admin-password)" に "rootpassword" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "ログアウトボタン(#admin-logout)" が存在

  シナリオ: 管理者を削除
    前提 管理者にID "admin"、パスワード "password" が存在
    前提 管理者にID "root"、パスワード "rootpassword" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック

    もし "管理者情報管理(#admin-admin)" をクリック
    ならば "管理者ID(#admin-id)" に "admin" と表示

    もし "管理者ID(#admin-id)" に "root" を入力
    かつ "削除ボタン(#admin-delete)" をクリック

    もし "1" 秒待機
    ならば "モーダル(#modal)" が存在
    かつ "(#modal-h4)" に "確認" と表示
    かつ "(#modal-p)" に "本当にこのアカウントを削除しますか？" と表示
    かつ "はい(#admin-delete-agree)" が存在
    かつ "はい(#admin-delete-agree)" に "はい" と表示
    かつ "いいえ(#admin-delete-disagree)" が存在

    もし "はい(#admin-delete-agree)" をクリック
    ならば "アラート(.alert-message)" に "アカウントを削除しました" と表示
    かつ "新しいパスワード(#admin-new-password)" に "" と表示
    かつ "確認パスワード(#confirm-admin-new-password)" に "" と表示
    かつ "管理者パスワード(#admin-password)" に "" と表示

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "root" を入力
    かつ "管理者パスワード(#admin-password)" に "rootpassword" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "アラート(.alert-message)" に "ログインに失敗しました" と表示

  シナリオ: 管理者登録（失敗）
    前提 管理者にID "admin"、パスワード "password" が存在
    
    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "管理者追加(#to-admin-register)" が存在

    もし "管理者追加(#to-admin-register)" をクリック
    ならば "登録ボタン(#admin-register)" が存在

    もし "管理者ID(#admin-id)" に "wrongadmin" を入力
    かつ "パスワード(#admin-password)" に "pass" を入力
    かつ "確認パスワード(#confirm-admin-password)" に "pass" を入力
    かつ "登録ボタン(#admin-register)" をクリック
    ならば "アラート(.alert-message)" に "エラーが発生しました" と表示
