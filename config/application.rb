require_relative "boot"
require "rails/all"
require 'rack/cors'
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

    # Rack::Cors を追加して Authorization ヘッダーを保持
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' # 必要に応じて制限（例: 'https://yourdomain.com'）
        resource '*',
                 headers: :any,
                 expose: ['Authorization'], # Authorization ヘッダーを公開
                 methods: %i[get post put patch delete options head]
      end
    end
  end
end
