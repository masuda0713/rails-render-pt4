require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # ユーザー情報が無効の場合は、ユーザー登録ボタンを押してもユーザーが作成されないことをテスト
  test "invalid signup information" do # 無効なサインアップ情報
    get new_user_registration_path # ユーザー登録ページにアクセス
    assert_no_difference 'User.count' do # User.countが変わらないことを確認
      post user_registration_path, params: { user: { name: "", # 無効なユーザー情報を送信
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity #HTTPステータスコードが422であることを確認
    assert_template 'devise/registrations/new' # devise/registrations/newテンプレートが表示されることを確認
  end

  # ユーザー情報が有効の場合は、ユーザー登録ボタンを押すとユーザーが作成されることをテスト
  test "valid signup information" do # 有効なサインアップ情報
    assert_difference 'User.count', 1 do # User.countが1増えることを確認
      post user_registration_path, params: { user: { name:  "Example User", # 有効なユーザー情報を送信
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect! # リダイレクト先のページに移動
    #assert_template 'users/show' # users/showテンプレートが表示されることを確認
    assert is_logged_in? # ログインしていることを確認
  end                                     
end
