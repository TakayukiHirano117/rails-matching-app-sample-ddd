# frozen_string_literal: true

class Match
  attr_reader :match_id, :user_id1, :user_id2

  def initialize(
    match_id:,
    user_id1:,
    user_id2:,
  )
    @match_id = match_id
    @user_id1 = user_id1
    @user_id2 = user_id2
  end

  def self.new(
    match_id:,
    user_id1:,
    user_id2:,
  )
    match_id, err = Uuid.new(match_id)
    return nil, err unless err.nil?

    user_id1, err = Uuid.new(user_id1)
    return nil, err unless err.nil?

    user_id2, err = Uuid.new(user_id2)
    return nil, err unless err.nil?

    super(match_id:, user_id1:, user_id2:)
  end

  def self.create(
    user_id1:,
    user_id2:,
  )
    new(
      match_id: SecureRandom.uuid,
      user_id1:,
      user_id2:,
    )
  end
end