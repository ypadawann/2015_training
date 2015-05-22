# 2015_training

## Usage

### 依存パッケージの導入

bundlerの導入が済んでいない場合は導入しておく必要があります。

```bash
$ gem install bundler
```

bundleコマンドで依存パッケージを導入することができます。

```bash
$ cd testapp
$ bundle install --path vendor/bundle
```


### Database

アプリケーションが使うデータベース名は環境変数RACK_ENVで決まります。

RACK_ENV=development なら development_db, RACK_ENV=test なら test_db を使います。

Sinatraを起動したときはデフォルトでは development に設定されます。

デフォルトの値がいやならば、コマンドの頭で環境変数を指定することもできます。

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
社員番号|id|int(11)|no|PRI, AUTOINC|NULL
氏名|name|varchar(50)|no||NULL
所属部署コード|department_id|int(11)|no|FK(departments.id)|NULL
パスワード|password|varchar(255)|no||NULL

**Timecardsテーブル**

説明|Field|Type|Null|Key|Default
--:|:--|:--|:--|:--|:--
通し番号|id|int(11)|no|PRI, AUTOINC|NULL
日付|day|date|no||NULL
社員番号|user_id|int(11)|no|FK(users.id)|NULL
入室時刻|attendance|time|yes||NULL
退出時刻|leaving|time|yes
