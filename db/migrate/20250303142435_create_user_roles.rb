class CreateUserRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_roles do |t|
      t.references :user, null: false, foreign_key: true # ユーザーID
      t.references :role, null: false, foreign_key: true # 権限ID
      t.timestamps
    end
  end
end
