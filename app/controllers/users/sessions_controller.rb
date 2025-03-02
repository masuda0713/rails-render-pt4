class Users::SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create] # ログイン時に `name` を許可する

  def new # ログインページ
    super # Devise::SessionsController の new アクションを呼び出す
  end

  def create # ログイン処理
    super # Devise::SessionsController の create アクションを呼び出す
    flash[:notice] = "ログインしました！ようこそ #{current_user.name} さん！" if is_flashing_format? # ログイン成功
  end

  def destroy # ログアウト処理
    super # Devise::SessionsController の destroy アクションを呼び出す
    flash[:notice] = "ログアウトしました。またのご利用をお待ちしています。" if is_flashing_format? # ログアウト成功
  end

  protected

  def after_sign_in_path_for(resource) # ログイン後のリダイレクト先
    user_path(resource) # ログイン後にプロフィールページにリダイレクト
  end

  #def configure_sign_in_params # ログイン時に `name` を許可する
  #  devise_parameter_sanitizer.permit(:sign_in, keys: [:name]) # name を許可
  #end
end
