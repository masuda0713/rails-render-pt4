require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  # homeページが表示されることを確認する
  test "should get home" do
    get static_pages_home_url # homeページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
    assert_select "title", "Home | Ruby on Rails Tutorial Sample App" # タイトルタグが正しいことを確認
  end

  # helpページが表示されることを確認する
  test "should get help" do
    get static_pages_help_url # helpページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App" # タイトルタグが正しいことを確認
  end

  # aboutページが表示されることを確認する
  test "should get about" do
    get static_pages_about_url # aboutページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
    assert_select "title", "About | Ruby on Rails Tutorial Sample App" # タイトルタグが正しいことを確認
  end

end
