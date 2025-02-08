require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)

# Dotenv を Rails の初期化前にロード
Dotenv::Railtie.load if defined?(Dotenv)

module SampleApp
  class Application < Rails::Application
    config.load_defaults 7.1

    # assets, tasksディレクトリをオートロードの対象外にする
    config.autoload_lib(ignore: %w(assets tasks))

    # Rack::Attack をミドルウェアとして追加
    config.middleware.use Rack::Attack
  end
end
