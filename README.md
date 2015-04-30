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

まず、事前にmysqlのコマンドラインツールで`test_db`テーブルを削除しておきます。

```bash
$ mysql -u hoge -p

mysql> DROP TABLE test_db;
mysql> quit
```

あとは該当のRakeタスクを叩いてください。

```bash
$ cd testapp
$ bundle exec rake db:migrate
```

