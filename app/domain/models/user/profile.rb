# frozen_string_literal: true
require './app/domain/models/vo/uuid.rb'
require './app/domain/models/vo/self_introduction.rb'
require './app/domain/models/vo/image_path.rb'


class Profile
  attr_reader :profile_id, :user_id, :introduction, :image_path

  def initialize(
    profile_id:,
    user_id:,
    introduction:,
    image_path:
  )
    @profile_id = profile_id
    @user_id = user_id
    @introduction = introduction
    @image_path = image_path
  end

  def self.new(
    profile_id:,
    user_id:,
    introduction:,
    image_path:
  )
    profile_id, err = Uuid.new(profile_id)
    return nil, err unless err.nil?

    user_id, err = Uuid.new(user_id)
    return nil, err unless err.nil?

    introduction, err = SelfIntroduction.new(introduction)
    return nil, err unless err.nil?

    image_path, err = ImagePath.new(image_path)
    return nil, err unless err.nil?

    super(profile_id:, user_id:, introduction:, image_path:)
  end

  def self.create(
    user_id:,
    introduction:,
    image_path:
  )
    profile_id = SecureRandom.uuid,
    user_id:,
    introduction:,
    image_path:

    new(profile_id:, user_id:, introduction:, image_path:)
  end
end