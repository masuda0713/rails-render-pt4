class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy # 権限とユーザーの中間テーブル
  has_many :users, through: :user_roles # 権限とユーザーの多対多の関連付け
end