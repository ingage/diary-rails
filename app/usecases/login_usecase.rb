class LoginUsecase < ApplicationUsecase

  def self.call(hash)
    new(**hash).call
  end

  #
  # Constructor
  #
  def initialize(username:, password:)
    @username = username
    @password = password
  end

  def call
    CognitoRepository.login(@username, @password)
  end

end
