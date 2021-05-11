# frozen_string_literal: true

case Rails.env
when 'development'
  # # 開発環境では localhost の redis にキャッシュする
  # Rails.application.config.session_store :redis_store, servers: {
  #   host:            ENV['REDIS_HOST'] || 'localhost',
  #   port:            6379,
  #   connect_timeout: 30, # Defaults to 20 seconds
  #   read_timeout:    0.2, # Defaults to 1 second
  #   write_timeout:   0.2, # Defaults to 1 second
  #
  #   # different key for app server
  #   namespace:       'diary-rails',
  # }

  # とりあえず、cache_store を使う
  Rails.application.config.session_store :cache_store
when 'staging', 'production'
  # # STG, PROD環境では elasticache にキャッシュする
  # Rails.application.config.session_store :redis_store, servers: {
  #   host:                ENV['ELASTICACHE_HOST'],
  #   port:                ENV['ELASTICACHE_PORT'],
  #
  #   # 最大1分くらいリトライする (initializers/redis.rb と同じ設定)
  #   connect_timeout:     0.5,
  #   reconnect_delay:     0.5,
  #   reconnect_delay_max: 10.0,
  #   reconnect_attempts:  10,
  #
  #   # different key for app server
  #   namespace:           'diary-rails',
  # }

  # とりあえず、cache_store を使う
  Rails.application.config.session_store :cache_store
else
  # テスト環境その他の環境ではキャッシュと同じ設定にする
  Rails.application.config.session_store :cache_store
end
