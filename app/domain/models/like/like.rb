# frozen_string_literal: true

class Like
  attr_reader :like_id, :sender_user_id, :receiver_user_id

  def initialize(
    like_id:,
    sender_user_id:,
    receiver_user_id:,
  )
    @like_id = like_id
    @sender_user_id = sender_user_id
    @receiver_user_id = receiver_user_id
  end

  def self.new(
    like_id:,
    sender_user_id:,
    receiver_user_id:,
  )
    like_id, err = Uuid.new(like_id)
    return nil, err unless err.nil?

    sender_user_id, err = Uuid.new(sender_user_id)
    return nil, err unless err.nil?

    receiver_user_id, err = Uuid.new(receiver_user_id)
    return nil, err unless err.nil?

    super(like_id:, sender_user_id:, receiver_user_id:)
  end

  def self.create(
    sender_user_id:,
    receiver_user_id:,
  )
    new(
      like_id: SecureRandom.uuid,
      sender_user_id:,
      receiver_user_id:,
    )
  end
end