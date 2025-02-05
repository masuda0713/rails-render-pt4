# config/initializers/rack_attack.rb

class Rack::Attack
  # 許可するIPリスト
  ALLOWED_IPS = [
    '133.32.227.23', # 自分のグローバルIP
    '192.168.0.10'    # 自分のローカルIP
  ]

  # X-Forwarded-For ヘッダーからIPを取得
  Rack::Attack.blocklist('block all except allowed IPs') do |req|
    client_ip = req.env["HTTP_X_FORWARDED_FOR"] || req.ip
    !ALLOWED_IPS.include?(client_ip)
  end
end