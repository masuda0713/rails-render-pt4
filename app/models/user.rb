class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 } # ユーザー名が存在することを検証。50文字以内であることを検証。
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # メールアドレスの正規表現。
  validates :email, presence: true, length: { maximum: 255 }, # メールアドレスが存在することを検証。255文字以内であることを検証。
                    format: { with: VALID_EMAIL_REGEX }, # 正規表現に一致することを検証。
                    uniqueness: true # 一意性を検証。
  validates :password, presence: true, length: { minimum: 6 } # パスワードが存在することを検証。6文字以上であることを検証。

  devise :database_authenticatable, # データベースを使用した認証を有効にする。メールアドレスとパスワードによる認証。
         :registerable, # ユーザー登録を有効にする。新規登録、編集、削除が可能。
         :recoverable, # パスワードリセットを有効にする
         :rememberable, # ログイン情報を保持する。Remember me機能。
         :validatable # メールアドレス、パスワードのバリデーションを有効にする。

  # ユーザーと権限の関連付け
  has_many :user_roles, dependent: :destroy # ユーザーと権限の中間テーブル
  has_many :roles, through: :user_roles # ユーザーと権限の多対多の関連付け

  # ユーザーに権限を追加する
  def has_role?(role_name) 
    roles.exists?(name: role_name) # 権限名が一致するレコードが存在するかどうかを判定
  end 
end
