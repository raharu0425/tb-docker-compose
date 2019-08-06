DokcerCompose環境の構築
====

Overview

## Description
ローカル環境を構築するに当たって、
docker-composeの設定を管理しているリポジトリ

## Requirement

.env :: 環境変数ファイル
セキュアな情報が入ってるのでリポジトリ管理されていない
プロジェクトのwikiから引っ張ってきて

/data  :: プロジェクトソース
ソースは別管理にしているのでリポジトリから引っ張ってくる

/logs  :: コンテナのエラーログ
このフォルダは作る

mkdir logs

## Usage

### 起動（ビルドもする）
$ docker-compose up -d --build

### 停止
$ dokcer-compose down

### 通常起動
$ docker-compose up -d

## Author
Yasuaki Watanabe (y.watanabe@newstech.jp)
