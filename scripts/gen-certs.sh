#!/usr/bin/env bash
# Sinh chứng chỉ TLS tự ký và file basic auth cho phpMyAdmin
set -euo pipefail

mkdir -p nginx/certs

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/certs/server.key \
  -out nginx/certs/server.crt \
  -subj "/C=VN/ST=ThaiNguyen/O=DE3-Lab/CN=localhost"

# Đổi MatKhauManh!2026 thành mật khẩu của bạn trước khi chạy
PMA_PASS='MatKhauManh!2026'
printf "admin:%s\n" "$(openssl passwd -apr1 "$PMA_PASS")" > nginx/.htpasswd

chmod 600 nginx/certs/server.key nginx/.htpasswd
echo "Đã tạo chứng chỉ và .htpasswd."
