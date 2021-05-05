# frozen_string_literal: true

Rails.application.routes.draw do
  root   to: redirect('/dashboard')

  get    'login'  => 'sessions#login'
  get    'logout' => 'sessions#logout'
  delete 'logout' => 'sessions#destroy'

  get 'auth/cognito-idp/callback' => 'cognito_idp#callback'
  get 'auth/failure'              => 'cognito_idp#failure'

  direct :cognito_logout do
    query = {
      client_id:  ENV['CLIENT_ID'],
      logout_uri: root_url,
    }.to_param
    "#{ENV['COGNITO_USER_POOL_SITE']}/logout?#{query}"
  end

  #
  # ここからログイン後の画面
  #
  get 'dashboard' => 'dashboard#show'
end
