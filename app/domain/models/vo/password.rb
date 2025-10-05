# frozen_string_literal: true
require "bcrypt"

class Password
  attr_reader :value
  
  def initialize(value:)
    @value = value
  end

  def self.new(value)
    return nil, "パスワードは必須です" if value.blank?
    return nil, "パスワードは8文字以上で入力してください" if value.length < 8
    return nil, "パスワードは100文字以内で入力してください" if value.length > 100
    # 生のパスワードの場合は基本的な文字列検証のみ行う
    # ハッシュ化されたパスワードの検証が必要な場合は別メソッドで実装
    # return nil, "パスワードの形式が正しくありません" unless BCrypt::Password.valid_hash?(value)

    super(value:)
  end

  private
end