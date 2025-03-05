# 権限マスタの登録
roles = {
  "admin"  => "管理者",
  "editor" => "編集者",
  "user"   => "一般ユーザー",
  "viewer" => "閲覧者"
}

# 権限マスタの登録
roles.each do |name, description|
  Role.find_or_create_by!(name: name) do |role|
    role.description = description
  end
end

# メインのサンプルユーザーを1人作成する(admin)
admin_user = User.create!(
  name:  "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
)

# メインユーザーに管理者権限を付与
admin_user.roles << Role.find_by(name: "admin")

# 追加のサンプルユーザーを99人作成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"

  user = User.create!(
    name:  name,
    email: email,
    password: password,
    password_confirmation: password,
  )

  # 50% の確率で "editor"、30% で "user"、20% で "viewer" の権限をランダムに付与
  role_name = case rand(1..10)
  when 1..5 then "editor"  # 50%
  when 6..8 then "user"    # 30%
  else "viewer"            # 20%
  end

  user.roles << Role.find_by(name: role_name)
end