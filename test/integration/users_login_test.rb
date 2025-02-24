require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  # セットアップ
  def setup
    @user = users(:michael)
  end
  
  # 有効なメールアドレス/無効なパスワードでログインするテスト
  test "login with valid email/invalid password" do
    get new_user_session_path # ログインページにアクセス
    assert_template 'devise/sessions/new' # ログインページが表示されることを確認
    post user_session_path, params: { user: { email: @user.email, password: "invalid" } } # 無効なパスワードをセッション用のパスにPOSTで送る
    assert_not is_logged_in? # ログインしていないことを確認
    assert_response :unprocessable_entity # リクエストが正しく処理されなかったことを確認
    assert_template 'devise/sessions/new' # ログインページが再表示されることを確認
    assert_not session["warden.user.user.key"].present?, "セッションが存在する" # セッションが存在しないことを確認
    assert_not flash.empty? # フラッシュメッセージが空でないことを確認
    get root_path # ホームページにアクセス
    assert flash.empty? # フラッシュメッセージが空であることを確認
  end

  # 有効な情報でログインしてからログアウトするテスト
  test "login with valid information" do
    post user_session_path, params: { user: { email: @user.email,
                                              password: 'password' } } # 有効な情報でログイン
    assert is_logged_in? # ログインしていることを確認
    assert_redirected_to @user # リダイレクト先がプロフィールページであることを確認
    follow_redirect! # リダイレクト先に移動
    assert_template 'users/show' # プロフィールページが表示されることを確認
    assert_select "a[href=?]", new_user_session_path, count: 0 # ログインリンクが表示されないことを確認
    assert_select "a[href=?]", destroy_user_session_path # ログアウトリンクが表示されることを確認
    assert_select "a[href=?]", user_path(@user) # プロフィールリンクが表示されることを確認
    delete destroy_user_session_path # ログアウト
    assert_not is_logged_in? # ログインしていないことを確認
    assert_response :redirect # リクエストがリダイレクトされたことを確認
    assert_redirected_to root_url # ルートURLにリダイレクトされることを確認
    follow_redirect! # リダイレクト先に移動
    assert_select "a[href=?]", new_user_session_path # ログインリンクが表示されることを確認
    assert_select "a[href=?]", destroy_user_session_path, count: 0 # ログアウトリンクが表示されないことを確認
    assert_select "a[href=?]", user_path(@user), count: 0 # プロフィールリンクが表示されないことを確認
  end
end
