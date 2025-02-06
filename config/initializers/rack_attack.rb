require 'ipaddr'

class Rack::Attack
  # 許可するIPリスト（現在は未使用）
  # ALLOWED_IPS = [
  #   '133.32.227.23', # 自分のグローバルIP
  #   '192.168.0.10',  # 自分のローカルIP
  #   '127.0.0.1',     # ローカルホスト
  #   '100.64.0.0/10', # Renderの内部ネットワーク
  #   '10.0.0.0/8'     # RenderのヘルスチェックIP
  # ]

  # ヘルスチェック用エンドポイント "/up" は常に許可
  Rack::Attack.safelist('allow health checks') do |req|
    req.path == "/up"
  end

  # 許可リスト以外のIPをブロック（現在は無効化）
  # Rack::Attack.blocklist('block all except allowed IPs') do |req|
  #   client_ip = (req.env["HTTP_X_FORWARDED_FOR"] || req.ip).split(',').first.strip
  #   !ALLOWED_IPS.any? { |ip| IPAddr.new(ip).include?(client_ip) rescue false }
  # end

  # すべてのリクエストを許可（IP制限を無効化）
  Rack::Attack.safelist('allow all requests') do |req|
    true
  end
end
