class ApplicationController < ActionController::Base
  # before_action :authenticate # Basic認証。すべてのリクエストに認証を適用
  before_action :authenticate, if: -> { ENV["BASIC_AUTH_ENABLED"] == "true" } # 環境変数が true の時のみ認証

  # Devise のストロングパラメータを許可する
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
  end
  
  def hello
  end

  private

  # Basic認証
  def authenticate
    expected_username = ENV['BASIC_AUTH_USER']  # 環境変数から取得
    expected_password = ENV['BASIC_AUTH_PASSWORD'] # 環境変数から取得

    # ユーザー名とパスワードが一致しない場合、認証ダイアログを表示
    authenticate_or_request_with_http_basic do |username, password|
      # ユーザー名とパスワードが一致するかどうか
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  # Devise のストロングパラメータを許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
