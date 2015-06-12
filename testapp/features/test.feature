# language: ja

機能: 管理者機能
  サンプル用のテストアプリケーションの動作確認

  シナリオ: 初期化
    もし "初期化ページ(/test/init-data)" にアクセス

  シナリオ: ログイン画面を表示
    もし "ログイン画面(/admin)" にアクセス

    ならば "ID欄(#admin-id)" が存在
    かつ "パスワード欄(#admin-password)" が存在
    かつ "ログインボタン(#admin-login)" が存在

  @javascript
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

    ならば 管理者画面トップに移動


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

    ならば 管理者画面トップに移動

    もし "ユーザ情報管理(#admin-user)" をクリック

    ならば ユーザ情報管理画面に移動

    もし "トップページ(/admin/top)" にアクセス
    かつ "部署管理(#admin-department)" をクリック

    ならば 部署管理画面に移動

  シナリオ: ユーザ情報変更
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
    かつ "変更ボタン(#user-modify)" をクリック
    
    #ならば "メッセージ(#message)" に "ok" と表示

    かつ "ユーザ情報管理(/admin/user)" にアクセス
    かつ "ユーザID(#user-id)" に以下を入力
    """
    23
    """
    かつ "選択ボタン(#user-select)" をクリック

    ならば "ユーザ名(#user-name)" に "Battleship Haruna" と表示
