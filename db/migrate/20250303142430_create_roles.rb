class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false # 権限名
      t.text :description # 権限の説明
      t.timestamps
    end

    add_index :roles, :name, unique: true # 権限名に一意性制約を付与
  end
end
