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

    # 認証時間が分からなければ、ログイン画面に遷移
    return false unless verified?(userinfo)

    # 1分以内に検証している場合は、再検証しない
    return true unless need_reverify?(userinfo)

    # cognito から user 情報を取得
    user = COGNITO_CLIENT.get_user({ access_token: userinfo[:credentials]['token'] })
    user.present?
  rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException => e
    Rails.logger.debug("e.class:   #{e.class}")
    Rails.logger.debug("e.message: #{e.message}")

    false
  end
  helper_method :signed_in?

  def verified?(userinfo)
    verified_at = (userinfo || {}).fetch(:verified_at, nil)
    verified_at.present?
  end

  #
  # 検証済みかどうか？
  #
  def need_reverify?(userinfo)
    verified_at = (userinfo || {}).fetch(:verified_at, nil)
    reverify_at = Time.zone.at(verified_at) + VERIFY_INTERVAL_TIME.seconds

    # 認証時間が分からなければ、未検証とする
    return false if verified_at.nil?

    # 再検証時刻を過ぎていなければ、検証済みとする
    Time.zone.now > reverify_at
  end

end
