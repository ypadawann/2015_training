# 2015_training

traning application

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


### Database migration

Migration機能でテーブル管理できるようになりました。

この機能を使うためには、事前に`依存パッケージの導入`の項を済ませている必要があります。

まず、事前にmysqlのコマンドラインツールでテーブルを削除しておきます。

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
$ bundle exec rake db:migrate
```

### Database definitions

データベース名 test_db

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

**Timecards**

説明|Field|Type|Null|Key|Default
--:|:--|:--|:--|:--|:--
通し番号|id|int(11)|no|PRI, AUTOINC|NULL
日付|day|date|no||NULL
社員番号|user_id|int(11)|no|FK(users.id)|NULL
入室時刻|attendance|time|yes||NULL
退出時刻|leaving|time|yes
