class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create] # ユーザー登録時に `name` を許可する
  before_action :configure_account_update_params, only: [:update] # ユーザー情報更新時に `name` を許可する

  def new # ユーザー登録ページ
    super # Devise::RegistrationsController の new アクションを呼び出す
  end

  def create # ユーザー登録処理
    super # Devise::RegistrationsController の create アクションを呼び出す
    
    # ユーザー登録成功時にフラッシュメッセージを変更
    if resource.persisted? # resource が保存されたか確認
      user_role = Role.find_by(name: "user") # "user" ロールを検索
      resource.roles << user_role if user_role.present? # ユーザーにロールを付与
      flash[:notice] = "ユーザー登録が完了しました！ようこそ #{resource.name} さん！" if is_flashing_format?
    end
  end

  def edit # ユーザー情報編集ページ
    super # Devise::RegistrationsController の edit アクションを呼び出す
  end

  def update # ユーザー情報更新処理
    super # Devise::RegistrationsController の update アクションを呼び出す
    if resource.errors.empty?
      flash[:notice] = "プロフィールが更新されました！" if is_flashing_format?
    end
  end

  #def destroy # ユーザー削除処理
  #  super # Devise::RegistrationsController の destroy アクションを呼び出
  #end

  #def cancel # ユーザー登録キャンセル
  #  super # Devise::RegistrationsController の cancel アクションを呼び出す
  #end

  protected

  # ユーザー登録時に `name` を許可する
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # ユーザー情報更新時に `name` を許可する
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # ユーザー登録後のリダイレクト先を変更
  def after_sign_up_path_for(resource)
    user_path(resource) # ユーザー詳細ページへリダイレクト
  end

  # ユーザー情報更新後のリダイレクト先を変更
  def after_update_path_for(resource)
    user_path(resource)
  end
end
