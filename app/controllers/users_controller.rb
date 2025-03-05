class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show] # ログイン必須
  before_action :authorize_admin, only: [:index, :destroy] # 管理者権限のみ許可
  before_action :set_user, only: [:show] # ユーザーを取得
  load_and_authorize_resource # Cancancan の権限チェック

  def index # ユーザー一覧ページ
    @users = User.paginate(page: params[:page]) # ページネーション
  end

  def show # ユーザー詳細ページ
    @user = User.find(params[:id]) # ユーザーを1件取得
  end

  def destroy # ユーザー削除処理
    authorize! :destroy, @user # Cancancan の認可を適用
    if @user.destroy
      flash[:notice] = "ユーザーを削除しました。"
    else
      flash[:alert] = "ユーザーの削除に失敗しました。"
    end
    redirect_to users_path
  end

  private

  # ユーザーを取得
  def set_user
    @user = User.find(params[:id])
  end

  # ユーザー削除時に管理者権限を持つユーザーのみ許可
  def authorize_admin
    redirect_to(root_path, alert: "権限がありません。") unless current_user.has_role?(:admin)
  end
end
