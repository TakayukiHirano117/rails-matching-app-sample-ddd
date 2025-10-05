# Sequel Migration Example
# db/sequel_migrations/001_create_users.rb

Sequel.migration do
  up do
    create_table(:users) do
      column :id, :uuid, primary_key: true, default: Sequel.function(:gen_random_uuid)
      column :name, String, null: false, size: 100
      column :email, String, null: false, size: 255
      column :password_digest, String, null: false
      column :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      
      index :email, unique: true
    end
  end
  
  down do
    drop_table(:users)
  end
end
