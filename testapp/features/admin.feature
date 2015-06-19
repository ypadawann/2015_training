# language: ja

機能: 管理者機能
  サンプル用のテストアプリケーションの動作確認

  シナリオ: 初期化（管理者登録、部署登録、ユーザ登録）
    もし "初期化ページ(/test/init-data)" にアクセス

  シナリオ: ログイン画面を表示
    もし "ログイン画面(/admin)" にアクセス

    ならば "ログインボタン(#admin-login)" が存在

  シナリオ: ログイン処理
    もし "ログインページ(/admin/login)" にアクセス

    かつ "管理者ID(#admin-id)" に以下を入力
    """
    admin
    """
    かつ "管理者パスワード(#admin-password)" に以下を入力
    """
    password
    """
    かつ "ログインボタン(#admin-login)" をクリック

    ならば "ログアウトボタン(#admin-logout)" が存在

  シナリオ: ログイン処理（失敗）
    もし "ログインページ(/admin/login)" にアクセス
    かつ "管理者ID(#admin-id)" に以下を入力
    """
    admin
    """
    かつ "管理者パスワード(#admin-password)" に以下を入力
    """
    passwordpssword
    """
    かつ "ログインボタン(#admin-login)" をクリック
    ならば "アラート(.alert-message)" に "ログインに失敗しました" と表示


  シナリオ: ログイン後にページ遷移
    もし "ID(admin)" と "パスワード(password)" で管理者ログイン
    ならば "ログアウトボタン(#admin-logout)" が存在

    もし "ユーザ情報管理(#admin-user)" をクリック
    ならば "ユーザ情報変更ボタン(#user-modify)" が存在

    もし "トップページ(/admin/top)" にアクセス
    かつ "部署管理(#admin-department)" をクリック
    ならば "部署登録ボタン(#department-register)" が存在

  シナリオ: ユーザ情報変更
    もし "ID(admin)" と "パスワード(password)" で管理者ログイン
    かつ "ユーザ情報管理(#admin-user)" をクリック
    かつ "ユーザID(#user-id)" に以下を入力
    """
    23
    """
    かつ "選択ボタン(#user-select)" をクリック
    かつ "1" 秒待機
    ならば "ユーザ名(#user-name)" に "戦艦　榛名" と表示
    かつ "部署(#select-department)" で "大日本帝国海軍" が選択

    もし "ユーザ名(#user-name)" に以下を入力
    """
    Battleship Haruna
    """
    かつ "部署(#select-department)" で "呉鎮守府" を選択
    かつ "変更ボタン(#user-modify)" をクリック
    ならば "アラート(.alert-message)" に "ユーザ情報を変更しました" と表示
    
    もし "1" 秒待機
    かつ "ユーザID(#user-id)" に以下を入力
    """
    23
    """
    かつ "選択ボタン(#user-select)" をクリック
    ならば "ユーザ名(#user-name)" に "Battleship Haruna" と表示
    かつ "部署(#select-department)" で "呉鎮守府" が選択

    もし "新しいパスワード(#user-new-password)" に以下を入力
    """
    newpassword
    """
    かつ "確認パスワード(#confirm-user-new-password)" に以下を入力
    """
    wrongpassword
    """
    かつ "変更ボタン(#user-modify)" をクリック
    ならば "アラート(.alert-message)" に "パスワードが違います" と表示

    もし "確認パスワード(#confirm-user-new-password)" に以下を入力
    """
    newpassword
    """
    かつ "変更ボタン(#user-modify)" をクリック
    ならば "1" 秒待機
    かつ "アラート(.alert-message)" に "ユーザ情報を変更しました" と表示
    かつ "新しいパスワード(#user-new-password)" に "" と表示
    かつ "確認パスワード(#confirm-user-new-password)" に "" と表示

  シナリオ: ユーザのパスワードが変更されているか確認
    もし "ユーザログイン画面(/)" にアクセス
    かつ "ユーザID(#user_id)" に以下を入力
    """
    23
    """
    かつ "パスワード(#password)" に以下を入力
    """
    newpassword
    """
    かつ "ログインボタン(#login)" をクリック
    ならば "ログアウトボタン(#logout)" が存在

  シナリオ: ユーザを削除
    もし "ID(admin)" と "パスワード(password)" で管理者ログイン
    かつ "ユーザ情報管理(#admin-user)" をクリック
    かつ "ユーザID(#user-id)" に以下を入力
    """
    23
    """
    かつ "選択ボタン(#user-select)" をクリック
    ならば "1" 秒待機
    かつ "削除ボタン(#user-delete)" をクリック

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
    かつ "部署名(#select-department)" で "" が選択
    かつ "新しいパスワード(#user-new-password)" に "" と表示
    かつ "確認パスワード(#confirm-user-new-password)" に "" と表示

  シナリオ: 部署管理
    もし "ID(admin)" と "パスワード(password)" で管理者ログイン
    かつ "部署管理(#admin-department)" をクリック
    かつ "登録する部署名(#register-department-name)" に以下を入力
    """
    横須賀鎮守府
    """
    ならば "選択ボタン(#department-register)" をクリック

    もし "1" 秒待機
    かつ "登録する部署名(#register-department-name)" に以下を入力
    """
    横須賀鎮守府
    """
    かつ "選択ボタン(#department-register)" をクリック
    ならば "アラート(.alert-message)" に "すでに登録されている部署です" と表示
    
    もし "1" 秒待機
    かつ "部署(#select-department)" で "横須賀鎮守府" を選択
    かつ "新しい部署名(#new-department-name)" に以下を入力
    """
    ブラック鎮守府
    """
    ならば "部署名変更(#department-rename)" をクリック

    もし "1" 秒待機
    かつ "部署(#select-department)" で "ブラック鎮守府" を選択
    ならば "部署削除(#department-delete)" をクリック
    

  シナリオ: 管理者情報管理（パスワード変更）
    もし "ID(admin)" と "パスワード(password)" で管理者ログイン
    かつ "管理者情報管理(#admin-admin)" をクリック
    ならば "管理者ID(#admin-id)" に "admin" と表示

    もし "新しいパスワード(#admin-new-password)" に以下を入力
    """
    adminnewpassword
    """
    かつ "確認パスワード(#confirm-admin-new-password)" に以下を入力
    """
    wrongadminnewpassword
    """
    かつ "変更ボタン(#admin-modify)" をクリック
    ならば "アラート(.alert-message)" に "確認パスワードが違います" と表示
    
    もし "確認パスワード(#confirm-admin-new-password)" に以下を入力
    """
    adminnewpassword
    """
    かつ "変更ボタン(#admin-modify)" をクリック
    ならば "アラート(.alert-message)" に "認証に失敗しました" と表示

    もし "パスワード(#admin-password)" に以下を入力
    """
    wrongpassword
    """
    かつ "変更ボタン(#admin-modify)" をクリック
    ならば "アラート(.alert-message)" に "認証に失敗しました" と表示

    もし "パスワード(#admin-password)" に以下を入力
    """
    password
    """
    かつ "変更ボタン(#admin-modify)" をクリック
    ならば "1" 秒待機
    かつ "新しいパスワード(#admin-new-password)" に "" と表示

  シナリオ: パスワード変更の確認
    もし "ID(admin)" と "パスワード(adminnewpassword)" で管理者ログイン
    ならば "ログアウトボタン(#admin-logout)" が存在


  シナリオ: 管理者登録
    もし "ID(admin)" と "パスワード(adminnewpassword)" で管理者ログイン
    かつ "管理者情報管理(#to-admin-register)" をクリック
    ならば "管理者登録ボタン(#admin-register)" が存在

    もし "管理者ID(#admin-id)" に以下を入力
    """
    root
    """
    かつ "管理者パスワード(#admin-password)" に以下を入力
    """
    rootpassword
    """
    かつ "確認パスワード(#confirm-admin-password)" に以下を入力
    """
    wrongrootpassword
    """
    かつ "管理者登録ボタン(#admin-register)" をクリック
    ならば "アラート(.alert-message)" に "確認パスワードが違います" と表示

    もし "確認パスワード(#confirm-admin-password)" に以下を入力
    """
    rootpassword
    """
    かつ "管理者登録ボタン(#admin-register)" をクリック
    ならば "アラート(.alert-message)" に "登録に成功しました" と表示
    かつ "管理者ID(#admin-id)" に "" と表示
    かつ "パスワード(#admin-password)" に "" と表示
    かつ "確認パスワード(#confirm-admin-password)" に "" と表示

    もし "管理者ID(#admin-id)" に以下を入力
    """
    admin
    """
    かつ "管理者パスワード(#admin-password)" に以下を入力
    """
    secondpassword
    """
    かつ "確認パスワード(#confirm-admin-password)" に以下を入力
    """
    secondpassword
    """
    かつ "管理者登録ボタン(#admin-register)" をクリック
    ならば "アラート(.alert-message)" に "エラーが発生しました" と表示


  シナリオ: 管理者が登録されていることを確認
    もし "ID(root)" と "パスワード(rootpassword)" で管理者ログイン
    ならば "ログアウトボタン(#admin-logout)" が存在

  シナリオ: 管理者を削除
    もし "ID(admin)" と "パスワード(adminnewpassword)" で管理者ログイン
    かつ "管理者情報管理(#admin-admin)" をクリック
    ならば "管理者ID(#admin-id)" に "admin" と表示

    もし "管理者ID(#admin-id)" に以下を入力
    """
    root
    """

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
    #かつ "管理者ID(#admin-id)" に "" と表示
    かつ "新しいパスワード(#admin-new-password)" に "" と表示
    かつ "確認パスワード(#confirm-admin-new-password)" に "" と表示
    かつ "管理者パスワード(#admin-password)" に "" と表示

  シナリオ: 管理者が削除されたことを確認
    もし "ID(root)" と "パスワード(rootpassword)" で管理者ログイン
    ならば "アラート(.alert-message)" に "ログインに失敗しました" と表示
