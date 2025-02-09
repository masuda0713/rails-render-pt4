module ApplicationHelper

  # ページごとの完全なタイトルを返す
  def full_title(page_title = '') 
    base_title = "Ruby on Rails Tutorial Sample App" # 変数に値を割り当てる
    if page_title.empty? # page_titleが空の場合
      base_title # base_titleを返す
    else # page_titleが空でない場合
      "#{page_title} | #{base_title}" # 文字列を連結して返す
    end
  end
end