# Quiz App

Ruby on Rails（API）+ React（TypeScript + Vite）+ Docker 構成のクイズアプリケーションです。

詳細なセットアップ手順や使い方は [README.md](../README.md) をご覧ください。

## バックエンドの起動

```bash
# Dockerを使う場合（推奨）
docker-compose up backend

# ローカルで直接起動する場合
bundle install
rails db:create db:migrate
rails server
```

## API エンドポイント

開発中...

## コード品質

```bash
# RuboCop でチェック
rubocop

# 自動修正
rubocop -A
```
