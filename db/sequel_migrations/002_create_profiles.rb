# Sequel Migration: create_profiles
# /app/db/sequel_migrations/002_create_profiles.rb

Sequel.migration do
  up do
    create_table(:profiles) do
      column :id, :uuid, primary_key: true, default: Sequel.function(:gen_random_uuid)
      column :self_introduction, String, size: 1000
      column :image_path, String, size: 500
      column :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      # 外部キー制約（カラムも自動作成される）
      foreign_key :user_id, :users, type: :uuid, key: :id, on_delete: :cascade, null: false
      
      # インデックス
      index :user_id, unique: true  # 1ユーザーに1プロフィール
    end
  end
  
  down do
    drop_table(:profiles)
  end
end
