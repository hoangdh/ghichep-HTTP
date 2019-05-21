## Ghi chép cấu hình SSL cho APACHE - NGINX

## APACHE

### Cấu hình VirtualHost và tự động chuyển từ HTTP sang HTTPS

**Chuyển HTTP sang HTTPS**

```
<VirtualHost *:80>
    ServerAdmin hoangdh@runsystem.net
    ServerName files.diennuocdaiphong.com
    ServerAlias www.files.diennuocdaiphong.com
	RewriteEngine On
	RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
    ErrorLog /opt/hoang-nextcloud/file-error.log
    CustomLog /opt/hoang-nextcloud/file-access.log combined
</VirtualHost>
```

**Cấu hình SSL**

```
<VirtualHost *:443>
	ServerName files.diennuocdaiphong.com
	DocumentRoot "/opt/hoang-nextcloud/"  
	<Directory "/opt/hoang-nextcloud">
		 AllowOverride all
		 Require all granted
	</Directory>
	ErrorLog /opt/hoang-nextcloud/nextcloud-error.log
	CustomLog /opt/hoang-nextcloud/nextcloud-access.log combined
	ServerName files.diennuocdaiphong.com:443
	ErrorLog /opt/hoang-nextcloud/ssl_error_log
	TransferLog /opt/hoang-nextcloud/ssl_access_log
	LogLevel warn
	SSLEngine on
	SSLProtocol all -SSLv2 -SSLv3
	SSLCipherSuite ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS

	SSLHonorCipherOrder on
	SSLOptions +StrictRequire

	SSLCertificateFile /etc/letsencrypt/live/files.diennuocdaiphong.com/cert.pem
	SSLCertificateKeyFile /etc/letsencrypt/live/files.diennuocdaiphong.com/privkey.pem
	SSLCertificateChainFile /etc/letsencrypt/live/files.diennuocdaiphong.com/chain.pem

	<Files ~ "\.(cgi|shtml|phtml|php3?)$">
		SSLOptions +StdEnvVars
	</Files>
	<Directory "/var/www/cgi-bin">
		SSLOptions +StdEnvVars
	</Directory>

	BrowserMatch "MSIE [2-5]" \
	nokeepalive ssl-unclean-shutdown \
	downgrade-1.0 force-response-1.0

	CustomLog logs/ssl_request_log \
	"%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
</VirtualHost>
```

- Chú ý:
	- `SSLCertificateFile`: Chứng chỉ của SSL (Public key - *.crt)
	- `SSLCertificateKeyFile`: Private Key (.KEY)
	- `SSLCertificateChainFile`: Chứng chỉ xác nhận Nhà cung cấp SSL
	
## NGINX

### Chuyển HTTP sang HTTPS

```
  server {
		listen       80;
		listen       [::]:80;
		server_name	 mail.nangtamgroup.vn;
		return 301 https://$host$request_uri;
	}
```

### Cấu hình SSL

```
 server {
		listen       443 ssl http2;
		server_name  mail.nangtamgroup.vn;
		root         /opt/nginx-ssl/;

		ssl_certificate "/etc/letsencrypt/live/mail.nangtamgroup.vn/cert.pem";
		ssl_certificate_key "/etc/letsencrypt/live/mail.nangtamgroup.vn/privkey.pem";
		ssl_session_cache shared:SSL:1m;
		ssl_session_timeout  10m;
		ssl_ciphers HIGH:!aNULL:!MD5;
		ssl_prefer_server_ciphers on;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    add_header Strict-Transport-Security "max-age=31536000; includeSubdomains; preload";

		# Load configuration files for the default server block.
		include /etc/nginx/default.d/*.conf;

		location / {
		}

		error_page 404 /404.html;
			location = /40x.html {
		}

		error_page 500 502 503 504 /50x.html;
			location = /50x.html {
		}
   }
```

- Chú ý:
	- `ssl_certificate`: Chứng chỉ của SSL (Public key - *.crt)
	- `ssl_certificate_key`: Private Key (.KEY)
	
