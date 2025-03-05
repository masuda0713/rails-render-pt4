#!/bin/bash
set -e

# サーバーのPIDファイルが残っている場合は削除
rm -f /sample-app/tmp/pids/server.pid

# サーバーを起動
exec "$@"