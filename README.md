# 概要
マッチングアプリを題材としたDDD x オニオンアーキテクチャのサンプルAPIです。
エンジニアゼミでの発表を前提としているため社内で多くの人がわかるRuby, Railsを使用しました。

あくまでDDDの雰囲気を知ってもらうという目的のために作成したので、
細かい仕様の策定やログインなどの認証機能については実装していません。

## 起動コマンド
docker compose -f docker-compose.dev.yml up

## データベース関連

### Sequel ORM マイグレーション

#### マイグレーションファイルの作成
```bash
# 新しいマイグレーションファイルを作成
docker compose -f docker-compose.dev.yml exec web bundle exec rake "sequel:create_migration[migration_name]"

# 例: Usersテーブル作成
docker compose -f docker-compose.dev.yml exec web bundle exec rake "sequel:create_migration[create_users]"

# 例: カラム追加
docker compose -f docker-compose.dev.yml exec web bundle exec rake "sequel:create_migration[add_age_to_users]"
```

#### マイグレーションの実行
```bash
# マイグレーション実行
docker compose -f docker-compose.dev.yml exec web bundle exec rake sequel:migrate

# マイグレーションのロールバック
docker compose -f docker-compose.dev.yml exec web bundle exec rake sequel:rollback

# 特定のバージョンまでロールバック
docker compose -f docker-compose.dev.yml exec web bundle exec rake sequel:rollback VERSION=1

# 現在のマイグレーションバージョン確認
docker compose -f docker-compose.dev.yml exec web bundle exec rake sequel:version
```

## テストコマンド
docker compose -e RAILS_ENV=test exec web bundle exec rspec

## Rubocop
docker compose -e RAILS_ENV=development exec web bundle exec rubocop -a

