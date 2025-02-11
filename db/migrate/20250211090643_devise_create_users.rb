class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name,               null: false, limit: 50 # ユーザ名
      t.string :email,              null: false, limit: 100 # メールアドレス。一意性制約を付与
      t.string :encrypted_password, null: false, limit: 100 # パスワード
      t.string   :reset_password_token # パスワードリセットトークン
      t.datetime :reset_password_sent_at # パスワードリセット送信日時
      t.datetime :remember_created_at # ログイン情報記憶日時
      t.timestamps null: false # 作成日時、更新日時
    end

    add_index :users, :email,                unique: true # メールアドレスの一意性
    add_index :users, :reset_password_token, unique: true # パスワードリセットトークンの一意性
  end
end
