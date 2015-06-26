# language: ja

機能: 管理者機能
  サンプル用のテストアプリケーションの動作確認

  シナリオ: ログイン画面を表示
    もし "ログイン画面(/admin)" にアクセス
    ならば "ログインボタン(#admin-login)" が存在

    もし "ユーザ情報管理画面(/admin/users)" にアクセス
    ならば "ログインボタン(#admin-login)" が存在

  シナリオ: ログイン処理（マウスクリック）
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "ログアウトボタン(#admin-logout)" が存在

    もし "ユーザ情報管理ページ(/admin/user)" にアクセス
    ならば "ユーザ情報変更ボタン(#user-modify)" が存在

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
    
    もし "部署管理(#admin-department)" をクリック
    ならば "部署登録ボタン(#department-register)" が存在

    もし "管理者情報管理(#admin-admin)" をクリック
    ならば "管理者情報変更ボタン(#admin-modify)" が存在

    もし "管理者追加(#to-admin-register)" をクリック
    ならば "管理者登録ボタン(#admin-register)" が存在

    もし "トップページ(#to-top)" をクリック
    ならば "ページ(body)" 内に "管理画面トップ" という記述が存在


  シナリオ: ログイン後にページ遷移(トップページから)
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
   
    もし "ログインボタン(#admin-login)" をクリック
    ならば "ログアウトボタン(#admin-logout)" が存在

    もし "ユーザ情報管理(#top__admin-user)" をクリック
    ならば "ユーザ情報変更ボタン(#user-modify)" が存在
    
    もし "管理者情報管理(#to-top)" をクリック
    かつ "部署管理(#top__admin-department)" をクリック
    ならば "部署登録ボタン(#department-register)" が存在

    もし "管理者情報管理(#to-top)" をクリック
    かつ "管理者情報管理(#top__admin-admin)" をクリック
    ならば "管理者情報変更ボタン(#admin-modify)" が存在

    もし "管理者情報管理(#to-top)" をクリック
    かつ "管理者追加(#top__to-admin-register)" をクリック
    ならば "管理者登録ボタン(#admin-register)" が存在



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
    かつ "1" 秒待機
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
    ならば "アラート(.alert-message)" に "確認パスワードが違います" と表示

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

  シナリオ: ユーザ情報の取得がエンターキーでできるか
    前提 管理者にID "admin"、パスワード "password" が存在
    前提 ユーザにID "23"、名前 "Haruna"、部署 "Navy"、パスワード "userpassword"、入社日 "1915-04-19" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック

    もし "ユーザ情報管理(#admin-user)" をクリック
    ならば "ユーザID(#user-id)" に "23" を入力
    かつ "その場で(#user-id)" で "エンターキー(Enter)" をキー入力

    もし "1" 秒待機
    ならば "ユーザ名(#user-name)" に "Haruna" と表示
    かつ "部署(#select-department)" で "Navy" が選択

  シナリオ: ユーザを一覧から選択
    前提 管理者にID "admin"、パスワード "password" が存在
    前提 ユーザにID "23"、名前 "Haruna"、部署 "Navy"、パスワード "userpassword"、入社日 "1915-04-19" が存在
    前提 ユーザにID "5630"、名前 "Maki"、部署 "ITSecurity"、パスワード "password"、入社日 "2010-04-01" が存在
    前提 ユーザにID "5622"、名前 "Mori"、部署 "ITSecurity"、パスワード "password"、入社日 "2014-04-01" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック

    もし "ユーザ情報管理(#admin-user)" をクリック
    かつ "一覧(#get-users-list)" をクリック
    ならば "モーダル(#modal__user-list)" が存在
    かつ "1番目(#modal__user-select-target0)" に "23: Haruna" と表示
    かつ "2番目(#modal__user-select-target1)" に "5622: Mori" と表示
    かつ "3番目(#modal__user-select-target2)" に "5630: Maki" と表示

    もし "2番目(#modal__user-select-target1)" をクリック
    かつ "1" 秒待機
    ならば "ユーザID(#user-id)" に "5622" と表示
    かつ "ユーザ名(#user-name)" に "Mori" と表示
    かつ "部署(#select-department)" で "ITSecurity" が選択


  シナリオ: ユーザを削除
    前提 管理者にID "admin"、パスワード "password" が存在
    前提 ユーザにID "23"、名前 "Haruna"、部署 "Navy"、パスワード "userpassword"、入社日 "1915-04-19" が存在

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
    もし "モーダル(#modal__user-delete)" が存在
    かつ "モーダル(#modal__user-delete)" 内に "確認" という記述が存在
    かつ "モーダル(#modal__user-delete)" 内に "以下のユーザを本当に削除しますか？" という記述が存在
    かつ "(#modal__user-delete__user-id)" に "ID: 23" と表示
    かつ "(#modal__user-delete__user-name)" に "名前: Haruna" と表示
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
    ならば "アラート(.alert-message)" に "その部署名は既に登録されています。" と表示
    
    もし "1" 秒待機
    かつ "部署(#select-department)" で "横須賀鎮守府" を選択
    かつ "新しい部署名(#new-department-name)" に "ブラック鎮守府" を入力
    かつ "部署名変更(#department-rename)" をクリック
    ならば "アラート(.alert-message)" に "横須賀鎮守府 を ブラック鎮守府 に変更しました" と表示

    もし "1" 秒待機
    かつ "部署(#select-department)" で "ブラック鎮守府" を選択
    かつ "部署削除(#department-delete)" をクリック
    ならば "モーダル(#modal)" が存在
    かつ "メッセージ(#modal-p)" に "以下の部署を本当に削除しますか？" と表示

    もし "0.5" 秒待機
    ならば "(#modal__delete-department__name)" に "ブラック鎮守府" と表示

    もし "いいえ(#department-delete-disagree)" をクリック
    かつ "1" 秒待機
    ならば "ページ(body)" に "モーダル(#modal)" が存在しない

    もし "部署削除(#department-delete)" をクリック
    かつ "0.5" 秒待機
    ならば "(#modal__delete-department__name)" に "ブラック鎮守府" と表示

    もし "はい(#department-delete-agree)" をクリック
    かつ "0.5" 秒待機
    ならば "アラート(.alert-message)" に "ブラック鎮守府を削除しました" と表示
    かつ "部署(#select-department)" に "選択肢(ブラック鎮守府)" が存在しない

  シナリオ: エンターキーで部署登録
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック    

    もし "部署管理(#admin-department)" をクリック
    かつ "登録する部署名(#register-department-name)" に "横須賀鎮守府" を入力
    かつ "その場で(#register-department-name)" で "エンターキー(Enter)" をキー入力
    ならば "アラート(.alert-message)" に "横須賀鎮守府の登録に成功しました" と表示

    もし "1" 秒待機
    ならば "部署(#select-department)" で "横須賀鎮守府" を選択

  シナリオ: 部署名変更をエンターキーで行う
    前提 管理者にID "admin"、パスワード "password" が存在
    前提 部署 "Navy" が存在
    前提 部署 "Kure" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック    

    もし "部署管理(#admin-department)" をクリック
    ならば "部署(#select-department)" で "Kure" を選択

    もし "新しい部署名(#new-department-name)" に "新しい部署のなまえ" を入力
    ならば "その場で(#new-department-name)" で "エンターキー(Enter)" をキー入力
    
    もし "アラート(.alert-message)" に "Kure を 新しい部署のなまえ に変更しました" と表示
    ならば "部署(#select-department)" で "新しい部署のなまえ" を選択
    ならば "部署(#select-department)" で "Navy" を選択
 
  シナリオ: 管理者情報管理（パスワード変更）
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック


    もし "管理者情報管理(#admin-admin)" をクリック
    かつ "1" 秒待機
    ならば "管理者ID(#select-admin-id)" で "admin" が選択

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
    ならば "アラート(.alert-message)" に "そのIDは既に使われています。" と表示

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "root" を入力
    かつ "管理者パスワード(#admin-password)" に "rootpassword" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "ログアウトボタン(#admin-logout)" が存在

  シナリオ: エンターキーで管理者登録
    前提 管理者にID "admin"、パスワード "password" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック

    かつ "管理者情報管理(#to-admin-register)" をクリック
    ならば "管理者登録ボタン(#admin-register)" が存在

    もし "管理者ID(#admin-id)" に "root" を入力
    かつ "管理者パスワード(#admin-password)" に "rootpassword" を入力
    かつ "確認パスワード(#confirm-admin-password)" に "rootpassword" を入力
    かつ "その場(#confirm-admin-password)" で "エンターキー(Enter)" をキー入力
    ならば "アラート(.alert-message)" に "登録に成功しました" と表示
    かつ "管理者ID(#admin-id)" に "" と表示
    かつ "パスワード(#admin-password)" に "" と表示
    かつ "確認パスワード(#confirm-admin-password)" に "" と表示

    もし "トップページ(/admin/top)" にアクセス
    ならば "ログアウト(#admin-logout)" をクリック

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
    ならば "管理者ID(#select-admin-id)" で "admin" が選択

    もし "管理者ID(#select-admin-id)" で "root" を選択
    かつ "削除ボタン(#admin-delete)" をクリック

    もし "1" 秒待機
    ならば "モーダル(#modal)" が存在
    かつ "(#modal-h4)" に "確認" と表示
    かつ "(#modal-p)" に "本当に以下のアカウントを削除しますか？" と表示
    かつ "はい(#admin-delete-agree)" に "はい" と表示
    かつ "いいえ(#admin-delete-disagree)" が存在
    かつ "(#modal__admin-delete__admin-id)" に "管理者ID: root" と表示

    もし "はい(#admin-delete-agree)" をクリック
    ならば "アラート(.alert-message)" に "アカウントを削除しました" と表示
    かつ "管理者ID(#select-admin-id)" で "admin" が選択
    かつ "新しいパスワード(#admin-new-password)" に "" と表示
    かつ "確認パスワード(#confirm-admin-new-password)" に "" と表示
    かつ "管理者パスワード(#admin-password)" に "" と表示

    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に "root" を入力
    かつ "管理者パスワード(#admin-password)" に "rootpassword" を入力
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "アラート(.alert-message)" に "ログインに失敗しました" と表示

  シナリオ: 自身の管理者IDは削除できない
    前提 管理者にID "admin"、パスワード "password" が存在
    前提 管理者にID "root"、パスワード "rootpassword" が存在

    もし "ログインページ(/admin/login)" にアクセス
    ならば "管理者ID(#admin-id)" に "admin" を入力
    かつ "管理者パスワード(#admin-password)" に "password" を入力
    かつ "ログインボタン(#admin-login)" をクリック

    もし "管理者情報管理(#admin-admin)" をクリック
    ならば "管理者ID(#select-admin-id)" で "admin" が選択

    もし "削除ボタン(#admin-delete)" をクリック
    かつ "1" 秒待機
    ならば "モーダル(#modal)" が存在
    かつ "(#modal-h4)" に "確認" と表示
    かつ "(#modal-p)" に "本当に以下のアカウントを削除しますか？" と表示
    かつ "はい(#admin-delete-agree)" に "はい" と表示
    かつ "いいえ(#admin-delete-disagree)" が存在
    かつ "(#modal__admin-delete__admin-id)" に "管理者ID: admin" と表示

    もし "はい(#admin-delete-agree)" をクリック
    ならば "アラート(.alert-message)" に "自身のアカウントは削除できません" と表示
   
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
    ならば "アラート(.alert-message)" に "パスワードは8文字以上でなくてはなりません" と表示
