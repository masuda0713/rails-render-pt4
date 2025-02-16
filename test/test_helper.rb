ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors) # テストを並列実行
    fixtures :all # テストデータを読み込む

    # Devise のテスト用ヘルパーを追加
    include Rails.application.routes.url_helpers
  end
end
