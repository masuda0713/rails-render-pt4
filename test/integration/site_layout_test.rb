require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # レイアウトリンクのテスト
  test "layout links" do
    get root_path # ルートURLにアクセス
    assert_template 'static_pages/home' # homeページが表示されることを確認
    assert_select "a[href=?]", root_path, count: 2 # ルートURLへのリンクが2つ存在することを確認
    assert_select "a[href=?]", help_path # helpページへのリンクが存在することを確認
    assert_select "a[href=?]", about_path # aboutページへのリンクが存在することを確認
    assert_select "a[href=?]", contact_path # contactページへのリンクが存在することを確認
  end
end