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
    reverify(userinfo)
  rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException => e
    Rails.logger.debug("e.class:   #{e.class}")
    Rails.logger.debug("e.message: #{e.message}")
    false
  end
  helper_method :signed_in?

  #
  # 認証済みかどうか？
  #
  def verified?(userinfo)
    verified_at = (userinfo || {}).fetch(:verified_at, nil)
    verified_at.present?
  end

  #
  # 再検証が必要かどうか？
  #
  def need_reverify?(userinfo)
    verified_at = (userinfo || {}).fetch(:verified_at, nil)
    reverify_at = Time.zone.at(verified_at) + VERIFY_INTERVAL_TIME.seconds

    # 認証時間が分からなければ、未検証とする
    return false if verified_at.nil?

    # 再検証時刻を過ぎていなければ、検証済みとする
    Time.zone.now > reverify_at
  end

  #
  # 再検証する
  # TODO: access_token が切れたときに refresh_token を使ってのユーザ取得の処理が実装できてない
  # TODO: repository を直接アクセスしているので usecase 経由にする
  #
  def reverify(userinfo)
    user = CognitoRepository.me(userinfo[:access_token])
    raise Aws::CognitoIdentityProvider::Errors::NotAuthorizedException, 'reverify error' if user.blank?

    session[:_user_me][:verified_at] = Time.zone.now
  end

end
