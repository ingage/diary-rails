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
    @form = LoginForm.new
    reset_session
  end

  #
  # POST /login
  #
  def login
    @form = LoginForm.new(params.require('login_form'))
    return render :show if @form.invalid?

    response = @form.submit
    return render :show if response.nil?

    save_session(response.authentication_result)
    redirect_to dashboard_url
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
