# language:ja
機能: 有給登録
  有給取得日登録が正しく行われているかの動作確認

  シナリオ: ログイン中ではないアクセス
    もし 有給登録(/userpage/add_paid_vacation) 画面にアクセスした

    ならば トップ(/) 画面に遷移する

  シナリオ: 全休に一日分のデータを登録（成功時）
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2015-04-01 が存在する
    かつ 社員番号 1111, パスワード 12345 のユーザでログインしている

    もし 有給登録画面(/userpage/add_paid_vacation) にアクセスし、
    かつ 全休(#full-vacation) に 2015-06-15 を入力する
    かつ 登録ボタン(#regist-vacation) をクリックした

    ならば アラート(.alert-message) に 登録しました と表示する
    かつ 出退勤状況(/userpage/attendance_record) にアクセスし、
    かつ 年(#year) に 2015 を入力し、
    かつ 月(#month) に 6 を入力し、
    かつ 表示ボタン(#date-select) をクリックした (非同期)
    かつ 6月15日の有給休暇欄(#paid-vacation15) に 1 と表示する

  シナリオ: 全休に複数(三日分)のデータを登録（成功時）
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2014-04-01 が存在する
    かつ 社員番号 1111, パスワード 12345 のユーザでログインしている

    もし 有給登録画面(/userpage/add_paid_vacation) にアクセスし、
    かつ 全休(#full-vacation) に 2015-6-15 2015-6-20 2015-7-1 を入力する
    かつ 登録ボタン(#regist-vacation) をクリックした

    ならば アラート(.alert-message) に 登録しました と表示する
    かつ 出退勤状況(/userpage/attendance_record) にアクセスし、
    かつ 年(#year) に 2015 を入力し、
    かつ 月(#month) に 6 を入力し、
    かつ 表示ボタン(#date-select) をクリックした (非同期)
    かつ 6月15日の有給休暇欄(#paid-vacation15) に 1 と表示する
    かつ 6月20日の有給休暇欄(#paid-vacation20) に 1 と表示する
    かつ 月(#month) に 7 を入力し、
    かつ 表示ボタン(#date-select) をクリックした (非同期)
    かつ 7月1日の有給休暇欄(#paid-vacation1) に 1 と表示する

  シナリオ: 半休に一日分のデータを登録（成功時）
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2015-04-01 が存在する
    かつ 社員番号 1111, パスワード 12345 のユーザでログインしている

    もし 有給登録画面(/userpage/add_paid_vacation) にアクセスし、
    かつ 半休(#half-vacation) に 2015-6-15 を入力する
    かつ 登録ボタン(#regist-vacation) をクリックした

    ならば アラート(.alert-message) に 登録しました と表示する
    かつ 出退勤状況(/userpage/attendance_record) にアクセスし、
    かつ 年(#year) に 2015 を入力し、
    かつ 月(#month) に 6 を入力し、
    かつ 表示ボタン(#date-select) をクリックした
    かつ 6月15日の有給休暇欄(#paid-vacation15) に 0.5 と表示する

  シナリオ: 半休に複数（三日分）のデータを登録(成功時)
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2015-05-01 が存在する
    かつ 社員番号 1111, パスワード 12345 のユーザでログインしている

    もし 有給登録画面(/userpage/add_paid_vacation) にアクセスし、
    かつ 半休(#half-vacation) に 2015-6-15 2015-06-16 2015-6-17 を入力する
    かつ 登録ボタン(#regist-vacation) をクリックした

    ならば アラート(.alert-message) に 登録しました と表示する
    かつ 出退勤状況(/userpage/attendance_record) にアクセスし、
    かつ 年(#year) に 2015 を入力し、
    かつ 月(#month) に 6 を入力し、
    かつ 表示ボタン(#date-select) をクリックした
    かつ 6月15日の有給休暇欄(#paid-vacation15) に 0.5 と表示する
    かつ 6月16日の有給休暇欄(#paid-vacation16) に 0.5 と表示する
    かつ 6月17日の有給休暇欄(#paid-vacation17) に 0.5 と表示する

  シナリオ: 全休に一日分のデータを登録（失敗時）
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2015-04-01 が存在する
    かつ 社員番号 1111, パスワード 12345 のユーザでログインしている

    もし 有給登録画面(/userpage/add_paid_vacation) にアクセスし、
    かつ 全休(#full-vacation) に 2015-06 を入力する
    かつ 登録ボタン(#regist-vacation) をクリックした

    ならば アラート(.alert-message) に 登録に失敗しました と表示する

  シナリオ: 半休に複数(三日分)のデータを登録(失敗時)
    前提: id 1111 ユーザ名 test パスワード 12345 部署 TEST 入社年月日 2015-04-01 が存在する
    かつ 社員番号 1111, パスワード 12345 のユーザでログインしている

    もし 有給登録画面(/userpage/add_paid_vacation) にアクセスし、
    かつ 半休(#half-vacation) に 2015-06-01 2015-6-2 2015-6 を入力する
    かつ 登録ボタン(#regist-vacation) をクリックした

    ならば アラート(.alert-message) に 登録に失敗しました と表示する
