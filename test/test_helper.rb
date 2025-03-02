ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# テストデータを読み込む
module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors) # テストを並列実行
    fixtures :all # テストデータを読み込む

    # テストユーザーがログイン中の場合にtrueを返す
    def is_logged_in?
      #!session[:user_id].nil? # セッションにユーザーIDが存在するかどうかを確認

      # Deviseでは、wardenを使用するため、セッション情報を直接参照することはできない
      # そのため、`current_user` メソッドを使用してログイン中のユーザーを取得する
      !controller.current_user.nil? # ログイン中のユーザーが存在するかどうかを確認
    end

    # テストユーザーとしてログインする
    def log_in_as(user)
      # Deviseでは、sign_inメソッドを使用してログインする
      @controller.sign_in(user) # ユーザーをログイン
    end
  end
end

class ActionDispatch::IntegrationTest
  # テストユーザーとしてログインする
  def log_in_as(user, password: 'password', remember_me: '1')
    post user_session_path, params: { user: { email: user.email, password: password, remember_me: remember_me } }    
  end
end
