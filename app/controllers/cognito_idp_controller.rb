# frozen_string_literal: true

#
# cognito による sign in 用コントローラー
#
class CognitoIdpController < ApplicationController

  # user 情報取得前なので、検証しない
  skip_before_action :authenticate_user!

  #
  # GET /auth/cognito-idp/callback
  # 認証成功時の処理
  #
  def callback
    auth_data = request.env['omniauth.auth']
    session[:_user_me] = create_user_info(auth_data)

    redirect_to '/'
  end

  #
  # GET /auth/failure
  # 認証失敗時の処理
  #
  def failure
    redirect_to root_url, alert: 'Authentication failed.'
  end

  private

  def create_user_info(auth_data)
    {
      uid:         auth_data['uid'],
      info:        auth_data['info'].to_h,
      credentials: auth_data['credentials'].to_h,
      extra:       auth_data['extra'].to_h,
      verified_at: Time.zone.now.to_i,
    }
  end

end
