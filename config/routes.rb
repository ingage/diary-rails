# frozen_string_literal: true

Rails.application.routes.draw do
  get    'login'  => 'sessions#show'
  post   'login'  => 'sessions#login'
  get    'logout' => 'sessions#logout'
  delete 'logout' => 'sessions#destroy'

  get 'auth/cognito-idp/callback' => 'cognito_idp#callback'
  get 'auth/failure'              => 'cognito_idp#failure'

  direct :cognito_logout do
    query = {
      client_id:  ENV['COGNITO_CLIENT_ID'],
      logout_uri: login_url,
    }.to_param
    "#{ENV['COGNITO_USER_POOL_SITE']}/logout?#{query}"
  end

  #
  # ここからログイン後の画面
  #
  get '/' => 'main#show'

  get '/dynamodb' => 'dynamodb#index'

  #
  # API
  #
  namespace :api do
    namespace :v1 do
      resources :journals
      resources :categories
    end
  end
end
