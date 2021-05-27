# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
# require "active_record/railtie"
# require "active_storage/engine"
require 'action_controller/railtie'
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require "action_cable/engine"
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

#
# module の定義がないため、このようにしておく必要がある
# rubocop:disable Style/ClassAndModuleChildren
#
module DiaryRails
  #
  # rails configuration in application
  #
  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.time_zone = 'Asia/Tokyo'

    config.paths.add 'entities',        eager_load: true
    config.paths.add 'forms',           eager_load: true
    config.paths.add 'repositories',    eager_load: true
    config.paths.add 'usecases',        eager_load: true
    config.paths.add 'lib',             eager_load: true
    config.paths.add 'lib/errors',      eager_load: true
    config.paths.add 'lib/middlewares', eager_load: true

  end
end
# rubocop:enable Style/ClassAndModuleChildren
