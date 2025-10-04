# frozen_string_literal: true

class ImagePath
  attr_reader :value
  
  def initialize(value:)
    @value = value
  end

  def self.new(value)
    return nil, "画像パスは必須です" if value.blank?
    return nil, "画像パスは255文字以内で入力してください" if value.length > 255

    super(value:), nil
  end
end