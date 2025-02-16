require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  # newページが表示されることを確認する
  test "should get new" do
    get  new_user_registration_path # ユーザー登録ページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
  end
end
