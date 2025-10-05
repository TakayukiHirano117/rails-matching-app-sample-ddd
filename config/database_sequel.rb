# Sequel Database Configuration
require 'sequel'

# データベース接続設定
database_url = ENV.fetch('DATABASE_URL', 'postgres://postgres:password@db:5432/myapp_development')

# Sequelデータベース接続を作成
DB = Sequel.connect(database_url)

# 接続設定のオプション
DB.extension :pg_array, :pg_json

# hstore拡張は必要に応じて有効化
# DB.extension :pg_hstore

# ログ設定（開発環境）
if Rails.env.development?
  DB.loggers << Logger.new(STDOUT)
end

# タイムゾーン設定
Sequel.datetime_class = DateTime
Sequel.application_timezone = :local
Sequel.database_timezone = :utc

puts "Sequel connected to: #{database_url}"
