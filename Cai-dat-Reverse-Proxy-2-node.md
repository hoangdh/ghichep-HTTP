# Hướng dẫn cài đặt Reverse Proxy trên Ubuntu 16.04

### Menu

[1. Giới thiệu về Reverse Proxy](#1)

- [1.1 Giới thiệu ](#1.1)
- [1.2 Mô hình cài đặt ](#1.2)

[2. Tiến hành cài đặt ](#2)

- [2.1 Cài đặt và cấu hình NGINX ](#2.1)
- [2.2 Cài đặt và cấu hình Apache2 ](#2.2)
- [2.3 Kiểm tra ](#2.3)

[3. Giới hạn truy cập thư mục trên NGINX](#3)

- [3.1 Cấu hình NGINX ](#3.1)
- [3.2 Kiểm tra](#3.2)

[4. BONUS: Chặn truy cập vào một số thư mục của Webserver bằng NGINX] (#3)

- [4.1 Cấu hình NGINX ](#4.1)
- [4.2 Kiểm tra](#4.2)

<a name="1"></a>
## 1. Giới thiệu về Reverse Proxy

<a name="1.1"></a>
### 1.1 Giới thiệu

Apache và NGINX là 2 hệ thống Web server phổ biến và được sử dụng rộng dãi trong nhiều hệ thống lớn với ưu điểm chung đều là các phần mềm OpenSource. 

- Apache nổi tiếng làm việc hiệu quả với những xử lý động như PHP,...
- NGINX có điểm mạnh là xử lý rất nhanh các web tĩnh. 

Với những ưu điểm đó, người ta đã kết hợp NGINX và Apache lại với nhau để bổ trợ cho nhau giúp hệ thống Webserver thêm phần hoàn thiện và đạt hiệu quả cao.

- Apache:
    - Vai trò chung là web server
    - Trong bài lab này Apache giữ vai trò `Webserver`, source code và DB sẽ được đặt trên máy chủ này.
- Nginx:
    - Là một web server tương tự Apache
    - Trong bài lab này đóng vai trò là 1 `Reverse Proxy`
    - Nginx đứng trước để tiếp nhận các kết nối và che chắn cho Webserver Apache.

<img src="http://i1363.photobucket.com/albums/r714/HoangLove9z/rp3_zpsv7qqne4u.png" />

<a name="1.2"></a>
### 1.2 Mô hình cài đặt

<img width=75% src="http://i1363.photobucket.com/albums/r714/HoangLove9z/rp-3_zpsvkjlv5iv.png" />

 | Reverse Proxy | Webserver |
--- | --- | --- |
OS | Ubuntu 16.04 | Ubuntu 16.04 |
NIC | eth0 | eth0 |
IP | 192.168.100.194 | 192.168.100.195 |
Package| NGINX | APACHE |

<a name="2"></a>
## 2. Tiến hành cài đặt

<a name="2.1"></a>
### 2.1 Cài đặt và cấu hình NGINX ở node 1

- Cài đặt

    - Dùng `apt-get` để cài đặt NGINX
    
    ```sh
    apt-get install -y nginx
    ```

- Cấu hình

    - Mở file `default` bằng `vi`
        
        ```sh
        vi /etc/nginx/sites-available/default
        ```
        
    - Sửa file với nội dung sau:
    
        ```sh
        server {
            listen 80;
            server_name _;

            location / {
                proxy_pass http://192.168.100.195;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
            }
        }
        ```
        **Note:** 
        - `proxy_pass http://192.168.100.195;` địa chỉ của Webserver
        
- Kiểm tra cấu hình và khởi động
    
    - Kiểm tra cấu hình
        
        ```sh
        nginx -t
        ```
        
        <img src="http://image.prntscr.com/image/d0e39f11456d454d9fb8b0206d343827.png" />
       
   - Bật nginx và cho khởi động cùng hệ thống
   
        ```sh
        systemctl start nginx
        systemctl enable nginx
        ```
        
<a name="2.2"></a>
### 2.2 Cài đặt và cấu hình Apache2 ở node 2

- Cài đặt

    - Dùng `apt-get` để cài đặt Apache2 và PHP
    
    
    ```
    apt-get install -y apache2 php
    ```

- Cấu hình
    
    - Tạo file `index.php` để test thử
    
    
    ```
    echo '<?php phpinfo(); ?>' > /var/www/html/index.php
    ```
    
    - Bật apache2 và cho khởi động cùng hệ thống

    ```
    systemctl start apache2
    systemctl enable apache2
    ``` 
   
<a name="2.3"></a>

### 2.3 Kiểm tra

- Test thử bằng trình duyệt

Chúng ta truy cập bằng trình duyệt qua địa chỉ IP của Webserver - 192.168.100.195
    
<img src="http://i1363.photobucket.com/albums/r714/HoangLove9z/test-rp-2_zpsaoyjzjwt.png" />  

Nhìn vào phần tô đỏ, chúng ta thấy IP đang truy cập  là 192.168.100.5 khác so với Reverse Proxy - 192.168.100.194

<a name="3"></a>

## 3. Kiểm tra

Chúng ta truy cập bằng trình duyệt qua địa chỉ IP của Reverse Proxy - 192.168.100.194

<img src="http://i1363.photobucket.com/albums/r714/HoangLove9z/test-rp-1_zpsiqe0dmea.png" />  

Nhìn vào phần tô đỏ, chúng ta thấy IP đang truy cập  là Reverse Proxy - 192.168.100.194.

<a name="4"></a>

## 4. BONUS: Chặn truy cập vào một số thư mục của Webserver bằng NGINX

Trong một số trường hợp, chúng ta cần bảo vệ một số thư mục có chứa nội dung "nhạy cảm" vì vậy làm thế nào để bảo vệ chúng? Dưới đây, tôi sẽ sử dụng một máy tính với IP là `192.168.100.5` và một máy khác có IP là `192.168.100.250`. Ví dụ, tôi cho phép máy tính `192.168.100.5` có thể truy cập vào thư mục `/hoangdh`. Trên NGINX, chúng ta cấu hình như sau:

<a name="4.1"></a>

- Mở file cấu hình của domain chứa thư mục cần bảo vệ và thêm vào những dòng sau ở section `server`:

    ```
    [server]
    ...
     location /hoangdh/ {
          
              allow 192.168.100.5;
              deny all;
              proxy_pass http://192.168.100.195/$uri;
   }
    ...
    ```

- `/hoangdh/`: Thay thế thư mục bạn muốn bảo vệ vào 
- `allow 192.168.100.5;`: Cho phép IP 192.168.100.5 truy cập vào thư mục
- `deny all`: Cấm tất cả không cho phép truy cập trừ những IP `allow`
- `proxy_pass http://192.168.100.195/$uri;`: Đẩy request này sang Webserver `192.168.100.195`
    
Sau khi cấu hình xong, chúng ta cho nginx load lại file cấu hình.

```sh
nginx -s reload
```

<a name="4.2"></a>

Kiểm tra trên máy tính có IP  192.168.100.250, ta thấy truy cập đã bị chặn.

<img width=150% src="http://image.prntscr.com/image/ab136ebb25334ad29f26c207426cdccb.png" />

Kiểm tra trên máy tính có IP là 192.168.100.5, ta có thể vào bình thường.

<img src="http://image.prntscr.com/image/f187748dcb6349b0bd8e7e778d7d6303.png" />