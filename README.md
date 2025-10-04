# 概要
マッチングアプリを題材としたDDD x オニオンアーキテクチャのサンプルAPIです。
エンジニアゼミでの発表を前提としているため社内で多くの人がわかるRuby, Railsを使用しました。

あくまでDDDの雰囲気を知ってもらうという目的のために作成したので、
細かい仕様の策定やログインなどの認証機能については実装していません。

## 起動コマンド
docker compose -f docker-compose.dev.yml up

## テストコマンド
docker compose -e RAILS_ENV=test exec web bundle exec rspec

## Rubocop
docker compose -e RAILS_ENV=development exec web bundle exec rubocop -a

