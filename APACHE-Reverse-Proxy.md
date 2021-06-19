## Cấu hình HTTPD - Apache làm Reverse Proxy

Bạn có 2 web server một thằng chạy Apache, một thằng chạy IIS... mà muốn 2 trang này đều được public ra ngoài trong khi chỉ có 1 IP public? 

- **Chú ý**:
	- IIS lắng nghe trên port 8080 với domain có tên là `site1.hoangdh.com`
	- APACHE - XAMMP chạy port 80 và cấu hình VirtualHost `site1.hoangdh.com`

### Các bước cấu hình

- **Bước 1**: Kích hoạt `mod_proxy`
	
	- Mở file `httpd.conf` và bỏ comment những dòng sau:
	
	```
	Include "conf/extra/httpd-proxy.conf"
	LoadModule proxy_module modules/mod_proxy.so
	LoadModule proxy_connect_module modules/mod_proxy_connect.so
	LoadModule proxy_http_module modules/mod_proxy_http.so
	```
  
  - Bổ sung file `httpd-proxy.conf` nếu không có sẵn:

  ```
  #
  # Implements a proxy/gateway for Apache.
  # # Required modules: mod_proxy, mod_proxy_http
  #

  <IfModule proxy_module>
  <IfModule proxy_http_module>

  #
  # Reverse Proxy
  #
  ProxyRequests Off

  <Proxy *>
      Order deny,allow
      Allow from all
  </Proxy>

  </IfModule>
  </IfModule>
  ```
	
- **Bước 2**: Tạo Virtual Host lắng nghe

	- Tạo một file mới `vi /etc/httpd/conf.d/hoangdh.com.conf`

	```
	<VirtualHost *:80>
		ServerAdmin daohuyhoang87@gmail.com
		ServerName site1.hoangdh.com
		ProxyPreserveHost On
		ErrorLog "logs/site1-error.log"
		CustomLog "logs/site1-access.log" common
		<Location />
			ProxyPass http://site1.hoangdh.com:8080/
			ProxyPassReverse http://site1.hoangdh.com:8080/
			Order allow,deny
			Allow from all
		</Location>
	</VirtualHost>
	```
	
	- Khởi động lại HTTPD - Apache
	
	```
	systemctl restart httpd
	```
