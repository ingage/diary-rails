# frozen_string_literal: true

#
# webpack で bundle された javascript tag 生成用のヘルパー
#
module WebpackBundleHelper

  class BundleNotFound < StandardError; end

  def javascript_bundle_tag(entry, **options)
    path = asset_bundle_path("#{entry}.js")

    options = {
      src:   path,
      defer: true,
    }.merge(options)

    options.delete(:defer) if options[:async]

    javascript_include_tag '', **options
  end

  private

  MANIFEST_PATH = "http://#{ENV['WEBPACK_HOST']}:#{ENV['WEBPACK_PORT']}/assets/manifest.json"

  def manifest
    uri = URI(MANIFEST_PATH)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    response = http.get(uri.request_uri)
    @manifest ||= JSON.parse(response.body)
  end

  def asset_bundle_path(entry, **options)
    raise BundleNotFound, "Could not find bundle with name #{entry}" unless manifest.key? entry

    asset_path(manifest.fetch(entry), **options)
  end

end
