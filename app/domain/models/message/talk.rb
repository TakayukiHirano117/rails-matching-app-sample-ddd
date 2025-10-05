# frozen_string_literal: true

class Talk
  attr_reader :talk_id, :match_id

  def initialize(
    talk_id:,
    match_id:,
  )
    @talk_id = talk_id
    @match_id = match_id
  end

  def self.new(
    talk_id:,
    match_id:,
  )
    talk_id, err = Uuid.new(talk_id)
    return err unless err.nil?

    match_id, err = Uuid.new(match_id)
    return err unless err.nil?

    super(talk_id:, match_id:)
  end

  def self.create(
    match_id:,
  )
    new(
      talk_id: SecureRandom.uuid,
      match_id:,
    )
  end
end