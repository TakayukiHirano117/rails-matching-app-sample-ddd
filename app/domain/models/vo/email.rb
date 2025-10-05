# frozen_string_literal: true

class Email
  attr_reader :value
  
  def initialize(value:)
    @value = value
  end

  def self.new(value)
    return nil, "メールアドレスは必須です" if value.blank?
    return nil, "メールアドレスは255文字以内で入力してください" if value.length > 255
    return nil, "メールアドレスの形式が正しくありません" unless valid_email_format?(value)

    super(value:)
  end

  private

  def self.valid_email_format?(email)
    email_regex = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/
    email.match?(email_regex)
  end
end