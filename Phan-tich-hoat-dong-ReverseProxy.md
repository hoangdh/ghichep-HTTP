# Phân tích hoạt động của Reverse Proxy có lưu cache

### Menu

[1. Giới thiệu ](#1)

- [1.1 Mô hình ](#1.1)
- [1.2 Lợi ích khi sử dụng Reverse Proxy ](#1.2)
- [1.3 Mô tả hoạt động ](#1.3)

[2. Phân tích hoạt động ](#2)

- [2.1 Chuẩn bị](#2.1)
- [2.2 Phân tích](#2.2)

[3. Kết luận](#3)

<a name="1"></a>
## 1. Giới thiệu

- Apache:
    - Vai trò chung là web server
    - Trong bài lab này Apache giữ vai trò `Webserver`, source code và DB sẽ được đặt trên máy chủ này.
- Nginx:
    - Là một web server tương tự Apache
    - Trong bài lab này đóng vai trò là 1 `Reverse Proxy`
    - Nginx đứng trước để tiếp nhận các kết nối và che chắn cho Webserver Apache.

<img width=75% src="http://i1363.photobucket.com/albums/r714/HoangLove9z/rp3_zpsv7qqne4u.png" />

<a name="1.1"></a>
### 1.1 Mô hình

<img width=75% src="http://i1363.photobucket.com/albums/r714/HoangLove9z/RP-2_zpskoqy2wg0.png" />

 | Reverse Proxy | Webserver | USER |
--- | --- | --- | --- |
OS | Ubuntu 16.04 | Ubuntu 16.04 | Windows 7 |
NIC | eth0 | eth0 | LAN |
IP | 192.168.100.194 | 192.168.100.195 | 192.168.100.22 |
Package| NGINX | APACHE | Firefox + WireShark |

<a name="1.2"></a>
### 1.2 Lợi ích khi sử dụng Reverse Proxy

- Giảm tải cho Webserver
- Xử lý nhanh các request tĩnh
- Giấu được mô hình, tăng tính bảo mật

<a name="1.3"></a>
### 1.3 Mô tả hoạt động

Trong bài lab này, tôi sẽ bắt các gói tin tại máy chủ `Reverse Proxy` để phân tích luồng hoạt động của hệ thống khi mà người dùng truy cập.

- Bước 1: Request của `USER` đến `Reverse Proxy`
- Bước 2: Request của `USER` được `Reverse Proxy` chuyển đến `Webserver`
- Bước 3: Webserver trả về reponse cho `Reverse Proxy`, cache được lưu lại ở `Reverse Proxy`
- Bước 4: `Reverse Proxy` trả reponse cho `USER`
- Bước 5: Request của `USER` lần thứ 2 đến `Reverse Proxy`
- Bước 6: Request của `USER` lần thứ 2 được `Reverse Proxy` xử lý, nếu request yêu cầu có sẵn trong cache thì trả lại cho `USER`, nếu chưa có thì quay lại `Bước 2`, và tương tự như vậy đến lần thứ n.

<img width=75% src="http://i1363.photobucket.com/albums/r714/HoangLove9z/luong-rp_zpsvc4xzsvy.png" />

<a name="2"></a>
## 2. Phân tích hoạt động

<a name="2.1"></a>
### 2.1 Chuẩn bị

Dùng công cụ `tcpdump` để bắt gói tin trên máy chủ `Reverse Proxy` và các bước thực hiện như sau:

**Bước 1**: Bắt gói tin trên `Reverse Proxy`

```
tcpdump -p tcp -w /opt/proxy.pcap
```

**Bước 2** Tạo Request đến `Reverse Proxy`

Dùng Firefox truy cập vào `Reverse Proxy` với địa chỉ http://192.168.100.194

<img src="http://image.prntscr.com/image/b5b9121529f5451da1d84a7d122eb49a.png" />

Sau khi tải xong, bấm `CTRL` + `F5` để tạo request lần 2

**Bước 3**: Dừng việc bắt gói, lấy file `.pcap`

- Dừng bắt gói tin bằng `CTRL` + `C` ở Terminal

<img src="http://image.prntscr.com/image/5c2cd0e6fd3d49c29d8f493de781448c.png" />

- Dùng WinSCP lấy file `proxy.pcap` về và mở bằng WireShark

<img src="http://image.prntscr.com/image/25e6cd433d6848f790dc28dfd09735af.png" />

<a name="2.2"></a>
### 2.2 Phân tích hoạt động

### Request của USER lần thứ 1:

<img src="http://image.prntscr.com/image/ba8a4a797f7a45c599aaffdeda525720.png" />


- `No.12`, Người dùng có IP: 192.168.100.20 truy cập HTTP đến `Reverse Proxy` thông qua IP là 192.168.100.194
- `No.17`, `Reverse Proxy` có địa chỉ 192.168.100.194 sẽ gửi bản tin truy cập HTTP của Người dùng đến `Webserver` có IP là 192.168.100.195
- `No.19`,  `Webserver` (192.168.100.195) xử lý request rồi gửi lại response cho `Reverse Proxy` có địa chỉ là 192.168.100.194
- `No.25`, `Reverse Proxy` gửi trả response từ 192.168.100.195 đến người dùng có địa chỉ là 192.168.100.20

### Request của USER lần thứ 2:

<img src="http://image.prntscr.com/image/0069291ab27f43719d643d6c6d694e3d.png" />

- `No.15`, Người dùng có IP: 192.168.100.250 truy cập HTTP đến `Reverse Proxy` thông qua IP là 192.168.100.194
- `No.18`,  `Reverse Proxy` (192.168.100.194) xử lý request, và thấy request đã có ở trong cache vì thế nó sẽ trả reponse từ `Reverse Proxy` (192.168.100.194) về luôn cho Người dùng có địa chỉ là 192.168.100.250 mà **KHÔNG** phải gửi yêu cầu đến `Webserver`

<a name="3"></a>
### 3. Kết luận

Qua bài phân tích trên, chúng ta thấy được luồng hoạt động của mô hình này. Các request từ người dùng chỉ giao tiếp với Reverse Proxy không hề biết bên trong có máy chủ Web, đồng thời Reverse Proxy cũng lưu trữ lại cache việc này làm giảm tải cho Webserver không phải làm việc quá nhiều.