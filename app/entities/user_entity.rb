# frozen_string_literal: true

#
# ユーザ情報を保持するエンティティ
#
class UserEntity < ApplicationEntity

  # TODO: ActiveModel に準じるようにする
  attr_accessor :email,
                :expires_in,
                :access_token,
                :refresh_token

  def store_from_auth(email, cognito_auth_response)
    if !cognito_auth_response.is_a?(Seahorse::Client::Response) ||
       !cognito_auth_response.data.is_a?(Aws::CognitoIdentityProvider::Types::AdminInitiateAuthResponse)
      raise ArgumentError
    end

    result = cognito_auth_response.authentication_result
    self.email         = email
    self.expires_in    = result.expires_in
    self.access_token  = result.access_token
    self.refresh_token = result.refresh_token
    self
  end

  def store_from_data(cognito_response)
  end

end
