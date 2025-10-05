# frozen_string_literal: true

class MessageContent
  attr_reader :value

  def initialize(value:)
    @value = value
  end

  def self.new(value:)
    return nil, "メッセージ内容は必須です" if value.blank?
    return nil, "メッセージ内容は1文字以上1000文字以内で入力してください" if value.length > 1000

    super(value:)
  end
end