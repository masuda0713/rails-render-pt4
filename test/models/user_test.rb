require "test_helper"

# ユーザーモデルのテスト
class UserTest < ActiveSupport::TestCase

  def setup # テスト用のユーザーを作成
    @user = User.new(name: "Example User", email: "user@example.com", 
                      password: "password", password_confirmation: "password") # ユーザーを作成
  end

  test "should be valid" do # 有効なユーザーであることを確認
    assert @user.valid? # ユーザーが有効であることを確認
  end

  test "name should be present" do # ユーザー名が存在することを確認
    @user.name = "     " # ユーザー名を空文字にする
    assert_not @user.valid? # ユーザーが無効であることを確認
  end

  test "email should be present" do # メールアドレスが存在することを確認
    @user.email = "     " # メールアドレスを空文字にする
    assert_not @user.valid? # ユーザーが無効であることを確認
  end

  test "name should not be too long" do # ユーザー名が長すぎないことを確認
    @user.name = "a" * 51 # ユーザー名を51文字にする
    assert_not @user.valid? # ユーザーが無効であることを確認
  end
  
  test "email should not be too long" do # メールアドレスが長すぎないことを確認
    @user.email = "a" * 244 + "@example.com" # メールアドレスを256文字にする
    assert_not @user.valid? # ユーザーが無効であることを確認
  end

  test "email validation should accept valid addresses" do # 有効なメールアドレスを受け入れることを確認
    # 有効なメールアドレスの配列
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    # 有効なメールアドレスを1つずつ確認
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid" # どのメールアドレスで失敗したかを表示
    end
  end

  test "email addresses should be unique" do # メールアドレスが一意であることを確認
    duplicate_user = @user.dup # ユーザーを複製
    @user.save # ユーザーを保存
    assert_not duplicate_user.valid? # 複製したユーザーが無効であることを確認
  end

  test "password should be present (nonblank)" do # パスワードが存在することを確認
    @user.password = @user.password_confirmation = " " * 6 # パスワードを空文字にする
    assert_not @user.valid? # ユーザーが無効であることを確認
  end

  test "password should have a minimum length" do # パスワードが最小の長さを持つことを確認
    @user.password = @user.password_confirmation = "a" * 5 # パスワードを5文字にする
    assert_not @user.valid? # ユーザーが無効であることを確認
  end
end
