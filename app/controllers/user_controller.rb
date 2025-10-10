class UserController < ApplicationController
  # ユーザーのプロフィール更新用コントローラ
  def update_user_profile
    user_id = params[:user_id]
    introduction = params[:introduction]
    image_path = params[:image_path]

    # バリデーション
    
    # ユースケースの呼び出し
    user_usecase.update_user_profile(user_id:, introduction:, image_path:)

    # レスポンスの記載
  end
end