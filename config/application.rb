require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.load_defaults 5.2

    config.action_view.embed_authenticity_token_in_remote_forms = true
    # the framework and any gems in your application.
  end
end
