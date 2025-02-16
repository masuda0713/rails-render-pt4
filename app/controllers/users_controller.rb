class UsersController < ApplicationController
  
  def show # ユーザー詳細ページ
    @user  = User.find(params[:id]) # ユーザーを1件取得 
  end

  def index # ユーザー一覧ページ
    @users = User.all # ユーザーを全件取得
  end
end
