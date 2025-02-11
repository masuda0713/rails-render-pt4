require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  # homeページが表示されることを確認する
  test "should get home" do
    get root_path # homeページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
    assert_select "title", "Ruby on Rails Tutorial Sample App" # タイトルタグが正しいことを確認
  end

  # helpページが表示されることを確認する
  test "should get help" do
    get help_path # helpページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App" # タイトルタグが正しいことを確認
  end

  # aboutページが表示されることを確認する
  test "should get about" do
    get about_path # aboutページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
    assert_select "title", "About | Ruby on Rails Tutorial Sample App" # タイトルタグが正しいことを確認
  end

  # contactページが表示されることを確認する
  test "should get contact" do
    get contact_path # contactページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App" # タイトルタグが正しいことを確認
  end
end
