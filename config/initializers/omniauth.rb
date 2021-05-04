# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  on_failure do |env|
    Rails.logger.error "env['omniauth.error']: #{env['omniauth.error']}"
    Rails.logger.error "env['omniauth.error.type']: #{env['omniauth.error.type']}"
    Rails.logger.error "env['omniauth.error.strategy']: #{env['omniauth.error.strategy']}"

    Rails.logger.error "ENV['CLIENT_ID']: #{ENV['CLIENT_ID']}"
    Rails.logger.error "ENV['CLIENT_SECRET']: #{ENV['CLIENT_SECRET']}"
    Rails.logger.error "ENV['COGNITO_USER_POOL_SITE']: #{ENV['COGNITO_USER_POOL_SITE']}"
    Rails.logger.error "ENV['COGNITO_USER_POOL_ID']: #{ENV['COGNITO_USER_POOL_ID']}"
    Rails.logger.error "ENV['AWS_REGION']: #{ENV['AWS_REGION']}"
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end

  provider(
    :cognito_idp,
    ENV['CLIENT_ID'],
    ENV['CLIENT_SECRET'],
    client_options: {
      site: ENV['COGNITO_USER_POOL_SITE']
    },
    scope:          'email openid',
    user_pool_id:   ENV['COGNITO_USER_POOL_ID'],
    aws_region:     ENV['AWS_REGION'],
  )
end
