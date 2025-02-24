class Users::SessionsController < Devise::SessionsController

  def new # ログインページ
    super
  end

  def create # ログイン処理
    self.resource = warden.authenticate!(auth_options) # ログイン処理
    if resource # ログインに成功した場合
      set_flash_message!(:notice, :signed_in) # フラッシュメッセージ
      sign_in(resource_name, resource) # ログイン処理
      redirect_to after_sign_in_path_for(resource) # ログイン後にユーザー詳細ページにリダイレクト
    else # ログインに失敗した場合
      flash.now[:alert] = "メールアドレスまたはパスワードが違います" # フラッシュメッセージ
      redirect_to new_user_session_path # ログインページにリダイレクト
    end
  end

  def destroy # ログアウト処理
    sign_out # ログアウト処理
    redirect_to root_url # ルートURL
  end

  protected

  def after_sign_in_path_for(resource) # ログイン後のリダイレクト先
    user_path(resource) # プロフィールページ
  end
end
