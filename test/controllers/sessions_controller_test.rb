require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  # newアクションが表示されることを確認する
  test "should get new" do 
    get  new_user_session_path # ログインページにアクセス
    assert_response :success # 成功を意味するステータスコード200が返されることを確認
  end
end