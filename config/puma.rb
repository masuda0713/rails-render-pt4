# Pumaのスレッド設定
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 2 } # スレッド数を2に制限
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count } # スレッド数を2に制限
threads min_threads_count, max_threads_count # スレッド数を設定

# `production` 環境ではワーカー数を制限
if ENV.fetch("RAILS_ENV", "development") == "production"
  workers Integer(ENV.fetch("WEB_CONCURRENCY") { 1 }) # ワーカーを1に制限（メモリ使用を抑える）
end

# Pumaのタイムアウト設定
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# ポート番号を指定
port ENV.fetch("PORT") { 3000 }

# 環境設定
environment ENV.fetch("RAILS_ENV") { "development" }

# PIDファイルの場所を指定
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# `preload_app!` を追加（メモリ効率化）
preload_app!

# ワーカーの起動時にDB接続を確立
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# 'bin/rails restart' でサーバーを再起動するために必要
plugin :tmp_restart
