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

  #
  # Constructor
  #
  def initialize(params = nil)
    p = if params.present?
          params.permit(:username, :password)
        else
          {}
        end
    super(p)
  end

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
