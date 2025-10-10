# frozen_string_literal: true
require './app/domain/models/vo/uuid.rb'
require './app/domain/models/vo/user_name.rb'
require './app/domain/models/vo/email.rb'
require './app/domain/models/vo/password.rb'

class User
  attr_reader :user_id, :name, :email, :password, :profile_id

  # DBの値で再構築・新規作成
  # いずれのメソッドも最終的にinitializeを通る。
  # Rubyの慣例的にinitializeを直接呼ぶというより
  # newで呼び出すことが多いためprivateにしていない。
  def initialize(
    user_id:, # ユーザーID
    name:, # 名前
    email:, # メールアドレス
    password:, # パスワード
    profile_id: # プロフィールID
  )
    @user_id = user_id
    @name = name
    @email = email
    @password = password
    @profile_id = profile_id
  end

  # DBから取得したデータをドメインモデルに変換する
  # ファクトリーメソッドの役割
  # User.newではこのself.newが呼ばれる
  def self.new(
    user_id:,
    name:,
    email:,
    password:,
    profile_id:
  )
    user_id, err = Uuid.new(user_id)
    return nil, err unless err.nil?

    name, err = UserName.new(name)
    return nil, err unless err.nil?

    email, err = Email.new(email)
    return nil, err unless err.nil?

    password, err = Password.new(password)
    return nil, err unless err.nil?

    profile_id, err = Uuid.new(profile_id)
    return nil, err unless err.nil?

    super(user_id:, name:, email:, password:, profile_id:)
  end

  # 新規作成のファクトリーメソッド
  # ユーザー登録のユースケースで呼ぶ想定
  def self.create(
    name:,
    email:,
    password:
  )
    new(
      user_id: SecureRandom.uuid, 
      name:, 
      email:, 
      password:, 
      profile_id: SecureRandom.uuid
    )
  end

  # プロフィール更新用メソッド
  # これが書かれていることで「ユーザーはプロフィールを更新できるんだな」ということが分かる
  # コードのドキュメント化が促進される
  def change_profile_id(profile_id)
    @profile_id = profile_id
  end
end