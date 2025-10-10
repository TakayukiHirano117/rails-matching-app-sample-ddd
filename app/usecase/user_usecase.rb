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
end