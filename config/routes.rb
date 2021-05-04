# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#show'
  delete 'logout' => 'sessions#destroy'

  get 'auth/cognito-idp/callback' => 'cognito_idp#callback'
  get 'auth/failure'              => 'cognito_idp#failure'

  get 'dashboard' => 'dashboard#show'

  direct :cognito_logout do
    query = {
      client_id:  ENV['CLIENT_ID'],
      logout_uri: root_url
    }.to_param
    "#{ENV['COGNITO_USER_POOL_SITE']}/logout?#{query}"
  end
end
