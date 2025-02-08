class ApplicationController < ActionController::Base
  before_action :authenticate # Basic認証

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
end
