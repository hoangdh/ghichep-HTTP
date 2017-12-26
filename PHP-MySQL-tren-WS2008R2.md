## Hướng dẫn cài đặt PHP + MySQL lên IIS trên Windows Server 2008 R2

### Menu

- [1. Giới thiệu](#1)
- [2. Các bước tiến hành](#2)
	- [2.1 Cài đặt IIS](#21)
	- [2.2 Tải Microsoft Web Platform Installer 5.0](#22)
	- [2.3 Cài đặt PHP và MySQL](#23)
	- [2.4 Tạo pool ứng dụng PHP](#24)
	- [2.5 Tạo và Phân quyền thư mục chứa mã nguồn Website](#25)
	- [2.6 Tạo file test PHP ](#26)
- [3. Kiểm tra](#3)
- [4. Tham khảo](#4)


## 1. Giới thiệu

`IIS` - `Internet Infomation Services` là một Web Server nổi tiếng của Microsoft để chạy những ứng dụng `ASP.NET`. Nhưng hòa chung với xu thế Mã nguồn mở, `IIS` cũng có thể chạy các ứng dụng được viết bằng PHP sử dụng MySQL. Hướng dẫn dưới đây sẽ giúp bạn cấu hình PHP và MySQL chạy trực tiếp lên IIS trên Windows Server 2008 R2.

## 2. Các bước tiến hành

### 2.1 Cài đặt IIS

Chúng ta chuẩn bị một máy chủ đã cài đặt sẵn hệ điều hành Windows Server 2008 R2. Bước tiếp theo, chúng ta mở phần **Server Manager** (Bấm **Start**, gõ tìm kiếm **Server Manager**)

<img src="/images/1.srv-manager.png" />

- Cài đặt .NET Framework 3.5.1 và IIS

Chọn **Features** > **Add Features**:

<img src="/images/1.feature1.png" />

Tick chuột vào ".NET Framework 3.5.1 Features"

<img src="/images/1.feature2.png" />

Bấm **Next** để cài đặt.

<img src="/images/1.feature3.png" />

Một hộp thoại xuất hiện yêu cầu cài đặt IIS. Bấm **Add Required Role Service** để tiếp tục.

<img src="/images/1.feature4.png" />

Bấm **Next** để tiếp tục.

<img src="/images/1.feature5.png" />

Giới thiệu về IIS, bấm **Next** để tiếp tục.

<img src="/images/1.feature6.png" />

Tick chọn **Common HTTP Features**, **CGI** và **IIS Management Console**, sau đó **Next**

<img src="/images/1.feature7.png" />

Bấm **Install** để cài đặt.

<img src="/images/1.feature8.png" />

<img src="/images/1.feature9.png" />

Sau khi cài đặt xong, chúng ta truy cập theo địa chỉ sau bằng Trình duyệt đã cài trên Server để kiểm tra IIS. Mặc định: Internet Explorer.

```
http://localhost/
```

<img src="/images/1.test.png" />


### 2.2 Tải Microsoft Web Platform Installer 5.0

- **Bước 1:** Cài đặt .NET Framework 4.5

Link: https://www.microsoft.com/en-us/download/details.aspx?id=30653

- **Bước 2:** Tải công cụ Microsoft Web Platform Installer 5.0
	
Link: https://www.microsoft.com/web/downloads/platform.aspx

 