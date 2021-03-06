 # language:ja
機能: ユーザ画面
  シナリオ: ログイン中でないアクセス
    もし ユーザ(/userpage) 画面にアクセスした

    ならば トップ(/) 画面に遷移する

  シナリオ: ログイン中のユーザ画面を表示させる
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスした

    ならば 社員番号(#current-user-id) 欄に 1000 が表示され (非同期)
    かつ 名前(#current-user-name) 欄に abc が表示され
    かつ 出勤結果(#attend-message) 欄に 本日はまだ出勤していません。 が表示され
    かつ 退勤結果(#leave-message) 欄に 本日はまだ退勤していません。 が表示され

  シナリオ: 出勤/退勤ボタンをクリックする
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 出勤(#attend) ボタンをクリックした

    ならば 出勤結果(#attend-message) 欄に 出勤しました。 を含む表示がされる (非同期)

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 退勤(#leave) ボタンをクリックした

    ならば 退勤結果(#leave-message) 欄に 退勤しました。 を含む表示がされる (非同期)

  シナリオ: 出勤/退勤ボタンをクリックした後に、ページを更新する
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 出勤(#attend) ボタンをクリックし
    かつ 退勤(#leave) ボタンをクリックした
    かつ ユーザ(/userpage) 画面にアクセスした

    ならば 出勤結果(#attend-message) 欄に 本日は を含む表示がされる (非同期)
    かつ 退勤結果(#leave-message) 欄に 本日は を含む表示がされる (非同期)

  シナリオ: 同じ日に2回出勤/退勤ボタンをクリックする
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 出勤(#attend) ボタンをクリックし
    かつ 出勤(#attend) ボタンをクリックした

    ならば アラート(.alert-message) に 本日は既に出勤しています。 と表示する (非同期)

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 退勤(#leave) ボタンをクリックし
    かつ 退勤(#leave) ボタンをクリックした

    ならば アラート(.alert-message) に 本日は既に退勤しています。 と表示する (非同期)

  シナリオ: 出勤前に退勤ボタンをクリックする
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 退勤(#leave) ボタンをクリックした

    ならば アラート(.alert-message) に 本日はまだ出勤していません。 と表示する (非同期)

  シナリオ: ボタンをクリックしてページ遷移する
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 出退勤状況(#to-read-data) ボタンをクリックした

    ならば 勤務管理表(/userpage/attendance_record) 画面に遷移する

    もし ユーザ(/userpage) 画面にアクセスし
    かつ ユーザ情報変更(#to-modify) ボタンをクリックし

    ならば ユーザ情報管理(/userpage/modify) 画面に遷移する

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 有休取得日登録(#to-add-paid-vacation) ボタンをクリックした

    ならば 有休取得日登録(/userpage/add_paid_vacation) 画面に遷移する

  シナリオ: 有給残数ボタンをクリックして残り有給数を表示する
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 有給残数(#view-paid-vacation) ボタンをクリックした

    ならば アラートメッセージ(.alert-message) に 21 日 と表示する

  シナリオ: 出勤ブックマークレットを実行して新しいウインドウを開く
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 出勤ブックマークレット リンクをクリックし 新しいウインドウを開いた

    ならば 出勤ブックマークレット(/bookmarklet/attend) 画面に遷移する

  シナリオ: 退勤ブックマークレットを実行して新しいウインドウを開く
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ 退勤ブックマークレット リンクをクリックし 新しいウインドウを開いた

    ならば 退勤ブックマークレット(/bookmarklet/leave) 画面に遷移する

  シナリオ: ログアウトする
    前提: 部署 RDD が存在する
    かつ 社員番号 1000, 名前 abc, 所属 RDD, パスワード abc, 入社年月日 2014-04-01 のユーザが存在する
    かつ 社員番号 1000, パスワード abc のユーザでログインしている

    もし ユーザ(/userpage) 画面にアクセスし
    かつ ログアウト(#logout) ボタンをクリックした

    ならば トップ(/) 画面に遷移する
