# frozen_string_literal: true

#
# ログイン用のビジネスロジック
#
class LoginUsecase < ApplicationUsecase

  # class methods
  class << self

    def call(username:, password:)
      CognitoRepository.login(username, password)
    end

  end

end
