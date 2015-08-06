# 2015_training

## Deployment

### ファイルの保存場所

/home/trainingams/AMS/

### 起動

jsファイルやcssファイルが生成されていないならgulpを実行する

```bash
$ pwd
/home/trainingams/AMS/2015_training/testapp/public
$ gulp
```
Unicornの実行

```bash
$ pwd
/home/trainingams/AMS/2015_training/testapp
$ bundle exec unicorn -c unicorn.rb -E "環境名" -D
```

### npmパッケージの導入

パッケージがインストールされていない場合はpublicディレクトリで以下のコマンド

```bash
$ npm install
```
lodashが導入されていなければ以下のコマンドでpublicディレクトリ下にlodash.jsを作成
```bash
$ node_modules/.bin/lodash modern -o ./lodash.js
```

### 依存パッケージの導入

bundlerの導入が済んでいない場合は導入しておく必要があります。

```bash
$ gem install bundler
```

bundleコマンドで依存パッケージを導入することができます。

```bash
$ cd testapp
## テスト, 開発時用のgemを無視する
$ bundle install --path vendor/bundle --without test development
```


### Database

アプリケーションが使うデータベース名は環境変数RACK_ENVで決まります。

RACK_ENV=development なら development_db, RACK_ENV=test なら test_db を使います。

Sinatraを起動したときはデフォルトでは development に設定されます。

デフォルトの値がいやならば、実行時に -E オプションで環境変数を指定することもできます。

```bash
$ RACK_ENV=test rackup
```

とすれば test_db を使えます。


## Database migration

Migration機能でテーブル管理できるようになりました。

この機能を使うためには、事前に`依存パッケージの導入`の項を済ませている必要があります。

まず、事前にmysqlのコマンドラインツールでデータベースを作成しておきます。

```bash
$ mysql -u hoge -p

mysql> CREATE DATABASE test_db;
mysql> quit
```

もしtest_dbにテーブルが存在する場合は削除しておきます。

```bash
$ mysql -u hoge -p

mysql> DROP TABLE test_db.timecards;
mysql> DROP TABLE test_db.users;
mysql> DROP TABLE test_db.departments;
mysql> quit
```

あとは該当のRakeタスクを叩いてください。

```bash
$ cd testapp
$ RACK_ENV=test bundle exec rake db:migrate
```


## Development

開発時は、localhostで起動して動作の確認やテストを走らせることができます。

```bash
$ cd testapp
$ bundle install --path vendor/bundle --without production
```

assetファイルの準備は本番と同じです。

```bash
RACK_ENV=development rackup
```

これでsqliteを使ってlocalhostで起動します。
migrationスクリプトがsqliteに対応していないので、手動でadminなどの値を投入する必要があります。コマンドラインで以下のようにします。

```bash
irb(main):002:0> ENV['RACK_ENV'] = 'development'
=> "development"
(failed reverse-i-search)`require': ^C
irb(main):003:0> require './model/helpers'
=> true
irb(main):004:0> require './model/admins'
=> true
(failed reverse-i-search)`Model': ^C
irb(main):005:0> Model::Admins.add('admin','admin')
=> {}
```



## Database definitions

データベース名: development_db または test_db

**Departmentsテーブル**

説明|Field|Type|Null|Key|Default
--:|:--|:--|:--|:--|:--
部署コード|id|int(11)|no|PRI, AUTOINC|NULL
部署名|name|varchar(50)|no||NULL

**Usersテーブル**

説明|Field|Type|Null|Key|Default
--:|:--|:--|:--|:--|:--
通し番号|num|int(11)|no|PRI, AUTOINC|NULL
社員番号|id|int(11)|no||NULL
氏名|name|varchar(50)|no||NULL
所属部署コード|department_id|int(11)|no|FK(departments.id)|NULL
パスワード|password|varchar(255)|no||NULL

**Timecardsテーブル**

説明|Field|Type|Null|Key|Default
--:|:--|:--|:--|:--|:--
通し番号|id|int(11)|no|PRI, AUTOINC|NULL
日付|day|date|no||NULL
社員番号|user_id|int(11)|no||NULL
入室時刻|attendance|varchar(10)|yes||NULL
退出時刻|leaving|varchar(10)|yes||NULL
振替休暇予定日|prearranged_holiday|varchar(15)|yes||NULL
有給休暇|paid_vacation|float|yes||NULL
振替休暇取得日|holiday_acquisition|varchar(15)|yes||NULL
備考|etc|varchar(50)|yes||NULL


**Adminsテーブル**

説明|Field|Type|Null|Key|Default
--:|:--|:--|:--|:--|:--
通し番号|num|int(11)|no|PRI, AUTOINC|NULL
ユーザID|id|varchar(255)|no||NULL
パスワード|password|varchar(255)|no||NULL
