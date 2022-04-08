 ## Sử dụng NGINX làm Reversed Proxy cho MinIO

### 1. Cài đặt MinIO
### 2. Cài đặt NGINX
#### Cấu hình NGINX

Sửa file /etc/nginx/sites-available/default

```
upstream backend {
        server 10.10.16.14:9000 max_fails=3 fail_timeout=30s;
        server 10.10.17.15:9000 max_fails=3 fail_timeout=30s;
        server 10.10.18.16:9000 max_fails=3 fail_timeout=30s;
        server 10.10.19.17:9000 max_fails=3 fail_timeout=30s;
}

server {
 listen 80 default_server;
# To allow special characters in headers
 ignore_invalid_headers off;
 # Allow any size file to be uploaded.
 # Set to a value such as 1000m; to restrict file size to a specific value
 client_max_body_size 0;
 # To disable buffering
 proxy_buffering off;
 server_tokens off;
 location / {
   proxy_set_header X-Real-IP $remote_addr;
   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
   proxy_set_header X-Forwarded-Proto $scheme;
   proxy_set_header Host $http_host;

   proxy_connect_timeout 300;
   # Default is HTTP/1, keepalive is only enabled in HTTP/1.1
   proxy_http_version 1.1;
   proxy_set_header Connection "";
   chunked_transfer_encoding off;

   proxy_pass http://backend; # If you are using docker-compose this would be the hostname i.e. minio
   # Health Check endpoint might go here. See https://www.nginx.com/resources/wiki/modules/healthcheck/
   # /minio/health/live;
 }
}
```

## 3. Tham khảo
- https://docs.min.io/docs/setup-nginx-proxy-with-minio.html
