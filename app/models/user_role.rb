class UserRole < ApplicationRecord
  belongs_to :user # ユーザーに属する
  belongs_to :role # 権限に属する
end