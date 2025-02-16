class Users::RegistrationsController < Devise::RegistrationsController

  def new # ユーザー登録ページ
    @user = User.new # Userクラスの新しいインスタンスを作成
  end

  def create # ユーザー登録処理
    @user = User.new(user_params) # Userクラスの新しいインスタンスを作成

    if @user.save # ユーザー登録に成功した場合
      flash[:success] = "Welcome to the Sample App!" # フラッシュメッセージを表示
      sign_in(@user) # ユーザーをログイン状態にする
      redirect_to @user # ユーザープロフィールページへリダイレクト
    else
      render 'devise/registrations/new', status: :unprocessable_entity # ユーザー登録に失敗した場合
    end
  end

  private # この下はクラス外からアクセスできない

  def user_params # ユーザー登録時に許可する属性
    params.require(:user).permit(:name, :email, :password, :password_confirmation) # ユーザー登録時に許可する属性
  end

  protected # この下はサブクラスからもアクセスできる

  # サインアップ後のリダイレクト先を指定
  def after_sign_up_path_for(resource)
    user_path(resource) # ユーザー詳細ページへリダイレクト
  end
end
