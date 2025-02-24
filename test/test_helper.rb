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
      !session["warden.user.user.key"].nil? # セッションにユーザーIDが含まれているかどうかを確認
    end
  end
end
