class Rack::Attack
  # 許可するIPリスト（RenderのIPを追加）
  ALLOWED_IPS = [
    '133.32.227.23', # 自分のグローバルIP
    '192.168.0.10',  # 自分のローカルIP
    '0.0.0.0',       # ローカルテスト用
    '127.0.0.1',     # ローカルホスト
    '100.64.0.0/10', # Renderの内部ネットワーク
    '35.231.147.226', # Renderの一部の固定IP
  ]

  # X-Forwarded-For ヘッダーからIPを取得
  Rack::Attack.blocklist('block all except allowed IPs') do |req|
    client_ip = (req.env["HTTP_X_FORWARDED_FOR"] || req.ip).split(',').first.strip
    !ALLOWED_IPS.any? { |ip| IPAddr.new(ip).include?(client_ip) rescue false }
  end
end
