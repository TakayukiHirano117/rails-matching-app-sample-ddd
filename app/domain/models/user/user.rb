# frozen_string_literal: true
require './app/domain/models/vo/uuid.rb'
require './app/domain/models/vo/user_name.rb'
require './app/domain/models/vo/email.rb'
require './app/domain/models/vo/password.rb'

class User
  attr_reader :user_id, :name, :email, :password, :profile_id

  def initialize(
    user_id:,
    name:,
    email:,
    password:,
    profile_id:
  )
    @user_id = user_id
    @name = name
    @email = email
    @password = password
    @profile_id = profile_id
  end

  def self.new(
    user_id:,
    name:,
    email:,
    password:,
    profile_id:
  )
    user_id, err = Uuid.new(user_id)
    return nil, err unless err.nil?

    name, err = UserName.new(name)
    return nil, err unless err.nil?

    email, err = Email.new(email)
    return nil, err unless err.nil?

    password, err = Password.new(password)
    return nil, err unless err.nil?

    profile_id, err = Uuid.new(profile_id)
    return nil, err unless err.nil?

    super(user_id:, name:, email:, password:, profile_id:)
  end

  def self.create(
    name:,
    email:,
    password:
  )
    new(
      user_id: SecureRandom.uuid, 
      name:, 
      email:, 
      password:, 
      profile_id: SecureRandom.uuid
    )
  end
end