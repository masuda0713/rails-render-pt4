class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  # Basic認証
  def authenticate
    # 環境変数に設定したユーザー名とパスワードを取得
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
