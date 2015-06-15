# language: ja

機能: 管理者機能
  サンプル用のテストアプリケーションの動作確認

  シナリオ: 初期化
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

    #ならば "画面(#error_message)" に "403" と表示
    #かつ アラートに "ログインに失敗しました" と表示


  シナリオ: ログイン後にページ遷移
    もし ログイン

    ならば "ログアウトボタン(#admin-logout)" が存在

    もし "ユーザ情報管理(#admin-user)" をクリック

    ならば "ユーザ情報変更ボタン(#user-modify)" が存在

    もし "トップページ(/admin/top)" にアクセス
    かつ "部署管理(#admin-department)" をクリック

    ならば "部署登録ボタン(#department-register)" が存在

  シナリオ: ユーザ情報変更（名前、部署）
    もし ログイン
    かつ "ユーザ情報管理(#admin-user)" をクリック
    かつ "ユーザID(#user-id)" に以下を入力
    """
    23
    """
    かつ "選択ボタン(#user-select)" をクリック

    ならば "ユーザ名(#user-name)" に "戦艦　榛名" と表示
    かつ "部署(#select-department)" で "大日本帝国海軍" が選択

    もし "ユーザ名(#user-name)" に以下を入力
    """
    Battleship Haruna
    """
    かつ "部署(#select-department)" で "呉鎮守府" を選択
    かつ "変更ボタン(#user-modify)" をクリック
    
    #ならば "メッセージ(#message)" に "ok" と表示

    かつ "ユーザ情報管理(/admin/user)" にアクセス
    かつ "ユーザID(#user-id)" に以下を入力
    """
    23
    """
    かつ "選択ボタン(#user-select)" をクリック

    ならば "ユーザ名(#user-name)" に "Battleship Haruna" と表示
    かつ "部署(#select-department)" で "呉鎮守府" が選択


  シナリオ: 部署管理
    もし ログイン
    かつ "部署管理(#admin-department)" をクリック
    かつ "登録する部署名(#register-department-name)" に以下を入力
    """
    横須賀鎮守府
    """
    かつ "選択ボタン(#department-register)" をクリック

    ならば アラートに "登録" と表示
