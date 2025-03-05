# 権限マスタの登録
roles = {
  "admin"  => "管理者",
  "editor" => "編集者",
  "user"   => "一般ユーザー",
  "viewer" => "閲覧者"
}

# 権限マスタの登録
roles.each do |name, description|
  Role.find_or_create_by!(name: name) do |role| # すでに存在する場合は更新しない
    role.description = description # 権限の説明
  end
end

# メインのサンプルユーザー(管理者)を作成(重複防止)
admin_user = User.find_or_create_by!(email: "example@railstutorial.org") do |user|
  user.name = "Example User"
  user.password = "foobar"
  user.password_confirmation = "foobar"
end

# メインユーザーに管理者権限を付与(重複防止)
unless admin_user.roles.exists?(name: "admin")
  admin_user.roles << Role.find_by(name: "admin")
end

# 追加のサンプルユーザーを99人作成する
99.times do |n|
  email = "example-#{n+1}@railstutorial.org"
  next if User.exists?(email: email) # 既に存在する場合はスキップ

  name  = Faker::Name.name
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