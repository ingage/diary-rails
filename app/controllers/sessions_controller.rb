# frozen_string_literal: true

#
# ログイン画面表示用コントローラー
#
class SessionsController < ApplicationController

  # ログイン・ログアウト処理では認証処理はスキップする
  skip_before_action :authenticate_user!

  #
  # GET /login
  #
  def show
    reset_session
  end

  #
  # POST /login
  #
  def login
    resp = admin_initiate_auth_with_pass(login_params[:username], login_params[:password])
    save_session(resp.authentication_result)

    redirect_to dashboard_url
  rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException => e
    # TODO: 認証エラー時の表示
  end

  #
  # GET /logout
  #
  def logout
    reset_session
    redirect_to cognito_logout_url
  end

  #
  # DELETE /logout
  #
  def destroy
    reset_session
    redirect_to cognito_logout_url
  end

  private

  def admin_initiate_auth_with_pass(username, password)
    COGNITO_CLIENT.admin_initiate_auth(
      user_pool_id:    ENV['COGNITO_USER_POOL_ID'],
      client_id:       ENV['COGNITO_CLIENT_ID'],
      auth_flow:       'ADMIN_NO_SRP_AUTH',
      auth_parameters: {
        USERNAME:    username,
        PASSWORD:    password,
        SECRET_HASH: secret_hash(username),
      },
    )
  end

  def login_params
    params.permit(:username, :password)
  end

  def secret_hash(username)
    Base64.strict_encode64(
      OpenSSL::HMAC.digest(
        'sha256',
        ENV['COGNITO_CLIENT_SECRET'],
        "#{username}#{ENV['COGNITO_CLIENT_ID']}",
      ),
    )
  end

  def save_session(auth_result)
    session[:_user_me] = {
      verified_at:   Time.zone.now,
      expires_in:    auth_result.expires_in,
      access_token:  auth_result.access_token,
      refresh_token: auth_result.refresh_token,
      id_token:      auth_result.id_token,
    }
  end

end
