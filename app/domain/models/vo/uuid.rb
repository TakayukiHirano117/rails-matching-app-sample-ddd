# frozen_string_literal: true

class Uuid
  attr_reader :value

  def initialize(value:)
    @value = value
  end

  def self.new(value:)
    return nil, "UUIDは必須です" if value.blank?
    return nil, "UUIDは36文字で入力してください" if value.length != 36
    return nil, "UUIDの形式が正しくありません" unless value.match?(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/)

    super(value:)
  end
end