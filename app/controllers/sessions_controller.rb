# frozen_string_literal: true

#
# ログイン画面表示用コントローラー
#
class SessionsController < ApplicationController

  # TODO: Session 保持がうまく動作しないので CSRF Token の検証を一旦しないことにする
  # ログイン・ログアウト処理では認証処理はスキップする
  # skip_before_action :authenticate_user!

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

    user_entity = @form.submit
    return render :show if user_entity.nil?

    save_session(user_entity)
    redirect_to main_url
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
    }
  end

end
