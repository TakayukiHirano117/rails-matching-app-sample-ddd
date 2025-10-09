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
docker compose  exec -e RAILS_ENV=test web bundle exec rspec

### テスト環境でのDatabaseCleaner設定について

**⚠️ 重要な注意事項**

このプロジェクトでは、Docker環境でのテスト実行時にDatabaseCleanerのセーフガード機能を無効化しています。
これは開発・テスト環境でのみ使用される設定であり、**本番環境では絶対に使用しないでください**docker compose  exec -e RAILS_ENV=test web bundle exec rspec。

#### 現在の設定内容

`spec/rails_helper.rb`で以下の設定を行っています：

```ruby
# Docker環境でのDatabaseCleanerセーフガードを無効化
# 本番環境では使用しないこと - セキュリティリスクがあります
# この設定はテスト環境のDockerコンテナ内でのみ使用されます
if ENV['DATABASE_URL']&.match?(/@(?:db|host\.docker\.internal):/) && Rails.env.test?
  DatabaseCleaner.allow_remote_database_url = true
end
```

#### なぜこの設定が必要か

- DatabaseCleanerはデフォルトでリモートデータベースURLに対してセーフガード機能を有効にしています
- Docker環境では、データベースが別コンテナ（`db`サービス）で動作するため、リモートデータベースとして認識されます
- `DatabaseCleaner.allow_remote_database_url = true`により、このセーフガードを無効化してテストを実行可能にしています

#### 本番・ステージング環境での対応

本番やステージング環境では、以下のいずれかの方法を使用してください：

1. **専用のテストデータベースを使用**
   ```yaml
   # docker-compose.test.yml
   environment:
     DATABASE_URL: postgres://test_user:test_password@localhost:5432/test_database
   ```

2. **環境変数での制御**
   ```ruby
   # テスト環境でのみセーフガードを無効化
   if Rails.env.test? && ENV['DISABLE_DATABASE_SAFEGUARD'] == 'true'
     DatabaseCleaner.allow_remote_database_url = true
   end
   ```

3. **DatabaseCleanerを使用しない**
   ```ruby
   # 本番環境ではDatabaseCleanerを無効化
   unless Rails.env.production?
     # DatabaseCleaner設定
   end
   ```

**セキュリティ上の理由から、本番環境では必ず適切なデータベース分離とアクセス制御を実装してください。**

## Rubocop
docker compose -e RAILS_ENV=development exec web bundle exec rubocop -a

