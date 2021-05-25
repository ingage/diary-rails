# frozen_string_literal: true

#
# Cognito 呼び出し用リポジトリ
#
class CognitoRepository < ApplicationRepository

  # class methods
  class << self

    def login(username, password)
      res = COGNITO_CLIENT.admin_initiate_auth(
        user_pool_id:    ENV['COGNITO_USER_POOL_ID'],
        client_id:       ENV['COGNITO_CLIENT_ID'],
        auth_flow:       'ADMIN_NO_SRP_AUTH',
        auth_parameters: auth_parameters(username, password),
      )

      UserEntity.new.tap do |e|
        e.store_from_auth(username, res)
      end
    end

    def me(access_token)
      COGNITO_CLIENT.get_user({ access_token: access_token })
    end

    private

    def auth_parameters(username, password)
      {
        USERNAME:    username,
        PASSWORD:    password,
        SECRET_HASH: secret_hash(username),
      }
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

  end

end
