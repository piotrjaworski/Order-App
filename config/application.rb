require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OrderApp
  class Application < Rails::Application

    console do
      require "pry"
      config.console = Pry
    end

    config.time_zone = 'Warsaw'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :pl

    config.assets.precompile += %w( main.css )
  end
end
