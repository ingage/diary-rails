# frozen_string_literal: true

#
# ログイン画面表示用コントローラー
#
class SessionsController < ApplicationController

  # ログイン・ログアウト処理では認証処理はスキップする
  before_action :authenticate_user!

  def show
  end

  def destroy
    reset_session
    redirect_to cognito_logout_url
  end

end
