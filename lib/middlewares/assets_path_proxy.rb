# frozen_string_literal: true

require 'rack/proxy'

#
# javascript などのファイルを webpack-dev-server にリダイレクトするための
# プロキシ処理を実装した rack middleware
#
class AssetsPathProxy < Rack::Proxy

  def perform_request(env)
    return @app.call(env) unless proxy_webpack_server?(env)

    if Rails.env.development?
      dev_server = "#{ENV['WEBPACK_HOST']}:#{ENV['WEBPACK_PORT']}"
      env['HTTP_HOST']               = dev_server
      env['HTTP_X_FORWARDED_HOST']   = dev_server
      env['HTTP_X_FORWARDED_SERVER'] = dev_server
    end

    env['PATH_INFO'] = "/assets/javascripts/#{env['PATH_INFO'].split('/').last}"
    super
  end

  private

  def proxy_webpack_server?(env)
    env['PATH_INFO'].include?('/javascripts/')
  end

end
