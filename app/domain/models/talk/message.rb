# frozen_string_literal: true

class Message
  attr_reader :message_id, :sender_user_id, :receiver_user_id, :message_content

  def initialize(
    message_id:,
    sender_user_id:,
    receiver_user_id:,
    message_content:,
  )
    @message_id = message_id
    @sender_user_id = sender_user_id
    @receiver_user_id = receiver_user_id
    @message_content = message_content
  end

  def self.new(
    message_id:,
    sender_user_id:,
    receiver_user_id:,
    message_content:,
  )
    message_id, err = Uuid.new(message_id)
    return nil, err unless err.nil?

    sender_user_id, err = Uuid.new(sender_user_id)
    return nil, err unless err.nil?

    receiver_user_id, err = Uuid.new(receiver_user_id)
    return nil, err unless err.nil?

    message_content, err = MessageContent.new(message_content)
    return nil, err unless err.nil?

    super(message_id:, sender_user_id:, receiver_user_id:, message_content:)
  end

  def self.create(
    sender_user_id:,
    receiver_user_id:,
    message_content:,
  )
    new(
      message_id: SecureRandom.uuid,
      sender_user_id:,
      receiver_user_id:,
      message_content:,
    )
  end
end