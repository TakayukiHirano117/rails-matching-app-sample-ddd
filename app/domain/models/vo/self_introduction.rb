# frozen_string_literal: true

class SelfIntroduction
  attr_reader :value
  
  def initialize(value:)
    @value = value
  end

  def self.new(value)
    return nil, "自己紹介は必須です" if value.blank?
    return nil, "自己紹介は1000文字以内で入力してください" if value.length > 1000

    super(value:), nil
  end
end