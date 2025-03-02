require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  # セットアップ
  def setup
    @user = users(:michael)
  end
  
  # 1.有効なメールアドレス/無効なパスワードでログインするテスト
  test "login with valid email/invalid password" do
    get new_user_session_path # ログインページにアクセス
    assert_template 'devise/sessions/new' # ログインページが表示されることを確認

    # 無効なパスワードでログインを試みる
    post user_session_path, params: { user: { email: @user.email, password: "invalid" } } 

    assert_not is_logged_in? # ログインしていないことを確認
    assert_response :unprocessable_entity # HTTP ステータスが `422 Unprocessable Entity` であることを確認
    assert_template 'devise/sessions/new' # ログインページが再表示されることを確認
    assert_not flash.empty? # フラッシュメッセージが表示されることを確認

    get root_path # ホームページにアクセス
    assert flash.empty? # フラッシュメッセージが消えていることを確認
  end

  # 2.有効な情報でログインしてからログアウトするテスト
  test "login with valid information" do
    get new_user_session_path # ログインページにアクセス
    post user_session_path, params: { user: { email: @user.email, password: 'password' } } # 有効な情報でログイン
    assert is_logged_in? # ログインしていることを確認
    assert_redirected_to user_path(@user) # プロフィールページにリダイレクトされることを確認
    #assert_redirected_to @user # リダイレクト先がプロフィールページであることを確認
    follow_redirect! # リダイレクト先に移動
    assert_template 'users/show' # プロフィールページが表示されることを確認
    assert_select "a[href=?]", new_user_session_path, count: 0 # ログインリンクが表示されないことを確認
    assert_select "a[href=?]", destroy_user_session_path # ログアウトリンクが表示されることを確認
    assert_select "a[href=?]", user_path(@user) # プロフィールリンクが表示されることを確認

    # ログアウトを実行
    delete destroy_user_session_path # ログアウト
    assert_not is_logged_in? # ログインしていないことを確認
    assert_redirected_to root_url # ルートURLにリダイレクトされることを確認
    follow_redirect! # リダイレクト先に移動
    assert_select "a[href=?]", new_user_session_path # ログインリンクが表示されることを確認
    assert_select "a[href=?]", destroy_user_session_path, count: 0 # ログアウトリンクが表示されないことを確認
    assert_select "a[href=?]", user_path(@user), count: 0 # プロフィールリンクが表示されないことを確認
  end

  # 3. ログイン時にログイン情報を記憶するテスト
  test "login with remembering" do
    log_in_as(@user, remember_me: '1') # ログインしてログイン情報を記憶する
    #assert_not_nil cookies['remember_user_token'], "Remember token should be present" # ログイン情報が記憶されていることを確認
  end  

  # 4. ログイン時にログイン情報を記憶しないテスト
  test "login without remembering" do
    log_in_as(@user, remember_me: '0') # ログインしてログイン情報を記憶しない
    assert_nil cookies['remember_user_token'], "Remember token should be blank" # ログイン情報が記憶されていないことを確認
  end
end
