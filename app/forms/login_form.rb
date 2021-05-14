class LoginForm < ApplicationForm
  include ::ActiveModel::Model
  include ::ActiveModel::Attributes

  # ATTRIBUTES
  attribute :username, :string
  attribute :password, :string

  # VALIDATIONS
  validates :username, presence: true
  validates :password, presence: true

  #
  # Constructor
  #
  def initialize(params)
    p = params.permit(:username, :password)
    super(p)
  end

  def submit
    return nil if invalid?
    LoginUsecase.call(**self.attributes.symbolize_keys)
  rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException => e
    Rails.logger.debug("e.class:   #{e.class}")
    Rails.logger.debug("e.message: #{e.message}")

    self.errors << 'ログインに失敗しました'
  end

end
