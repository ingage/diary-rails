# frozen_string_literal: true

#
# base class for controller in application
#
class ApplicationController < ActionController::Base

  VERIFY_INTERVAL_TIME = 60

  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!

  private

  def authenticate_user!
    redirect_to('/login') unless signed_in?
  end

  def signed_in?
    userinfo = session[:_user_me]
    verified_at = (userinfo || {}).fetch(:verified_at, nil)

    # 認証時間が分からなければ、ログイン画面に遷移
    return false if verified_at.nil?

    # 1分以内に検証している場合は、再検証しない
    return true if Time.zone.now < Time.zone.at(verified_at) + VERIFY_INTERVAL_TIME.seconds

    # cognito から user 情報を取得
    user = COGNITO_CLIENT.get_user({
                                     access_token: userinfo[:credentials]['token'],
                                   })
    user.present?
  end
  helper_method :signed_in?

  def get_user_list(cognito_access_token)
    COGNITO_CLIENT.get_user({ access_token: cognito_access_token })
  end

end
