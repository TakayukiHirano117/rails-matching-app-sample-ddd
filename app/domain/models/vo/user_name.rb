# frozen_string_literal: true

class UserName
  attr_reader :value
  
  def initialize(value:)
    @value = value
  end

  def self.new(value)
    return nil, "名前は必須です" if value.blank?
    return nil, "名前は50文字以内で入力してください" if value.length > 50

    super(value:), nil
  end
end