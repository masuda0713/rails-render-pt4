# config/initializers/rack_attack.rb

class Rack::Attack
  # 許可するIPリスト
  ALLOWED_IPS = [
    '192.168.0.10', # 自分のIP
    '192.168.0.3'    # チームのIP
  ]

  # 許可IP以外は403エラー
  Rack::Attack.blocklist('block all except allowed IPs') do |req|
    !ALLOWED_IPS.include?(req.ip)
  end
end