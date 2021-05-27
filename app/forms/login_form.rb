# frozen_string_literal: true

#
# ログイン用フォーム
#
class LoginForm < ApplicationForm

  # ATTRIBUTES
  attribute :username, :string
  attribute :password, :string

  # VALIDATIONS
  validates :username, presence: true
  validates :password, presence: true

  def submit
    return nil if invalid?

    LoginUsecase.call(**attributes.symbolize_keys)
  rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException => e
    Rails.logger.debug("e.class:   #{e.class}")
    Rails.logger.debug("e.message: #{e.message}")

    errors.add(:base, 'ログインに失敗しました')
    nil
  end

end
