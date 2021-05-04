# frozen_string_literal: true

#
# cognito による sign in 用コントローラー
#
class CognitoIdpController < ApplicationController

  # skip_before_action :verify_authenticity_token
  # before_action :authenticate_user!, except: [:failure]

  def callback
    auth = request.env['omniauth.auth']
    session[:userinfo] = {
      uid:         auth['uid'],
      info:        auth['info'].to_h,
      credentials: auth['credentials'].to_h,
      extra:       auth['extra'].to_h
    }

    redirect_to '/dashboard'
  end

  def failure
    redirect_to root_url, alert: 'Authentication failed.'
  end

end
