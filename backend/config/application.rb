require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_view/railtie"
# require "action_cable/railtie"

Bundler.require(*Rails.groups)

module QuizApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    # CORS設定（開発環境用）
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        # 開発環境のフロントエンドURL
        origins ENV.fetch('FRONTEND_URL', 'http://localhost:5173'),
                'http://localhost:3000',
                'http://127.0.0.1:5173',
                'http://127.0.0.1:3000'

        resource '/api/*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true,
          max_age: 600
      end

      # ヘルスチェックエンドポイント
      allow do
        origins '*'
        resource '/health',
          headers: :any,
          methods: [:get, :head]
      end
    end

    # JSON APIのデフォルト設定
    config.middleware.use ActionDispatch::ContentSecurityPolicy::Middleware
  end
end
