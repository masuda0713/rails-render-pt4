class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  # Basic認証
  def authenticate
    expected_username = ENV['BASIC_AUTH_USER']  # ← ここを `BASIC_AUTH_USER` に修正
    expected_password = ENV['BASIC_AUTH_PASSWORD']

    Rails.logger.info "BasicAuth Attempt: ENV USERNAME=#{expected_username.present? ? 'SET' : 'MISSING'}, ENV PASSWORD=#{expected_password.present? ? 'SET' : 'MISSING'}"

    authenticate_or_request_with_http_basic do |username, password|
      is_authenticated = (username == expected_username && password == expected_password)

      Rails.logger.info "BasicAuth Login Attempt: Provided USERNAME=#{username}, Success=#{is_authenticated}"

      is_authenticated
    end
  end
end
