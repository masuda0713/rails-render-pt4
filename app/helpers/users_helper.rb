module UsersHelper 
  #　こちらに記述されたメソッドは、Usersコントローラーのビューで使用できる

  # 渡されたユーザーのGravatar画像を返す
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase) # メールアドレスを小文字に変換し、MD5ハッシュ値を計算
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}" # GravatarのURL
    image_tag(gravatar_url, alt: user.name, class: "gravatar") # 画像タグでGravatar画像を返す
  end
end