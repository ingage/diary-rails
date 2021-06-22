# frozen_string_literal: true

Aws.config.update(Rails.application.config_for(:aws).symbolize_keys)
# Aws.config.update({ credentials: Aws::SharedCredentials.new })

COGNITO_CLIENT = Aws::CognitoIdentityProvider::Client.new
if Rails.env.development?

  # NoSQL Workbench が発行した credentials を設定しても、同ツールでデータの参照ができない！！！
  access_key = ENV['AWS_ACCESS_KEY_ID'] || 'dummy'
  secret_key = ENV['AWS_SECRET_ACCESS_KEY'] || 'dummy'

  # https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html
  # Downloadable DynamoDB requires any credentials to work,
  DYNAMODB_CLIENT = Aws::DynamoDB::Client.new(
    credentials: Aws::Credentials.new(access_key, secret_key),
    endpoint: "http://#{ENV['DYNAMODB_HOST']}:8000",
  )
else
  DYNAMODB_CLIENT = Aws::DynamoDB::Client.new(
    endpoint: "http://#{ENV['DYNAMODB_HOST']}:8000",
  )
end
