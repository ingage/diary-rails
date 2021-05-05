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
  def login
    reset_session
  end

  #
  # GET /logout
  #
  def logout
    redirect_to login_url
  end

  #
  # DELETE /logout
  #
  def destroy
    reset_session
    redirect_to cognito_logout_url
  end

end
