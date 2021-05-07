# Journally

Ingage Inc. 用の日報登録サービス。

## 開発環境構築

### 前準備

`.env` を RAILS_ROOT に配置

```
# AWS
AWS_REGION=ap-northeast-1
AWS_ACCESS_KEY_ID=<aws key here>
AWS_SECRET_ACCESS_KEY=<aws secret here>
```

### 初回起動

```
# Docker ビルド
$ docker-compose build
# 各コンテナの起動 -d: background
$ docker-compose up -d
```

Mac から http://localhost:3007 でアクセスする。

### 初期データ投入

TBD

dynamodb にテーブル作って、初期データを投入する感じ

## 日々の開発運用

### 起動

```
# foreground
$ docker-compose up
# background
$ docker-compose up -d
```

### ログ確認

```
$ docker-compose logs web
# 末尾5行のみ
$ docker-compose logs --tail=5 web
```

### コマンド実行

```
# bundle install
$ docker-compose run web bundle install
```

### シェルで入る

```
$ docker-compose exec web /bin/bash
```

### 再起動

```
$ docker-compose restart web
```

### 停止

```
$ docker-compose down
# 全 image 削除
$ docker-compose down --rmi all
```

### プロセス確認

```
$ docker-compose ps
```
