# Sequel Model Example
# app/models/sequel/user.rb

class User < Sequel::Model
  # テーブル名を明示的に指定（オプション）
  set_dataset :users
  
  # バリデーション
  plugin :validation_helpers
  
  def validate
    super
    validates_presence [:name, :email]
    validates_unique :email
    validates_format /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, :email
  end
  
  # アソシエーション例
  one_to_one :profile
  one_to_many :sent_likes, class: :Like, key: :sender_user_id
  one_to_many :received_likes, class: :Like, key: :receiver_user_id
  
  # カスタムメソッド
  def full_name
    name
  end
  
  # パスワードハッシュ化（bcryptを使用する場合）
  # plugin :secure_password
end
