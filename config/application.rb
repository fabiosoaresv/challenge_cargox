require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module AdmProject
  class Application < Rails::Application
    config.load_defaults 6.0
    Rails.application.config.assets.version = '1.0'
    Rails.application.config.assets.precompile += %w( application.css )
    config.autoload_paths += %W(#{config.root}/app/services)
  end
end
