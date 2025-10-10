class UserUseCase
  # ユーザーのプロフィール更新用ユースケース
  def update_user_profile(user_id:, introduction:, image_path:)
    user = user_repository.find(user_id)
    
    # 新しいプロフィールを作成
    profile = Profile.create(
      user_id: user.user_id,
      profile_id: SecureRandom.uuid,
      introduction: introduction,
      image_path: image_path
    )
    
    # ユーザーのプロフィールIDを更新
    user.change_profile_id(profile.profile_id)
    
    # 両方を永続化
    # ここでトランザクションを切る
    user_repository.update(user)
    profile_repository.update(profile)
  end

  # ユーザーのいいね用ユースケース
  def like_user(sender_user_id:, receiver_user_id:)
    user_from_repository = user_repository.find(sender_user_id)
    sender_user, err = User.new(
      user_id: user_from_repository.user_id,
      name: user_from_repository.name,
      email: user_from_repository.email,
      password: user_from_repository.password,
      profile_id: user_from_repository.profile_id
    )
    return nil, err unless err.nil?

    like_user_from_repository = user_repository.find(receiver_user_id)
    receiver_user, err = User.new(
      user_id: like_user_from_repository.user_id,
      name: like_user_from_repository.name,
      email: like_user_from_repository.email,
      password: like_user_from_repository.password,
      profile_id: like_user_from_repository.profile_id
    )
    return nil, err unless err.nil?

    
    like = Like.create(
      sender_user_id: sender_user.user_id,
      receiver_user_id: receiver_user.user_id
    )
    
    # 両方を永続化
    like_repository.update(like)
  end
end