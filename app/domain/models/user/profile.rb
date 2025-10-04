# frozen_string_literal: true

class Profile
  attr_reader :profile_id, :user_id, :introduction, :image

  def initialize(
    profile_id:,
    user_id:,
    introduction:,
    image:
  )
    @profile_id = profile_id
    @user_id = user_id
    @introduction = introduction
    @image = image
  end

  def self.new(
    profile_id,
    user_id,
    introduction,
    image
  )
    profile_id, err = Uuid.new(profile_id)
    return err unless err.nil?

    user_id, err = Uuid.new(user_id)
    return err unless err.nil?

    introduction, err = SelfIntroduction.new(introduction)
    return err unless err.nil?

    image, err = ImagePath.new(image)
    return err unless err.nil?

    super(profile_id:, user_id:, introduction:, image:)
  end

  def self.create(
    user_id,
    introduction,
    image
  )
    profile_id = SecureRandom.uuid
    user_id,
    introduction,
    image

    new(profile_id:, user_id:, introduction:, image:)
  end
end