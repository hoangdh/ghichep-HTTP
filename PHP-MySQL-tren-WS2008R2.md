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


<a name="1"> 

## 1. Giới thiệu

`IIS` - `Internet Infomation Services` là một Web Server nổi tiếng của Microsoft để chạy những ứng dụng `ASP.NET`. Nhưng hòa chung với xu thế Mã nguồn mở, `IIS` cũng có thể chạy các ứng dụng được viết bằng PHP sử dụng MySQL. Hướng dẫn dưới đây sẽ giúp bạn cấu hình PHP và MySQL chạy trực tiếp lên IIS trên Windows Server 2008 R2.

<a name="2"> 

## 2. Các bước tiến hành

<a name="2.1"> 

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

<a name="2.1"> 

### 2.2 Tải Microsoft Web Platform Installer 5.0

- **Bước 1:** Cài đặt .NET Framework 4.5

Link: https://www.microsoft.com/en-us/download/details.aspx?id=30653

Chạy file và cài đặt .NET

<img src="/images/2.net45.png" />

Tick vào ô đồng ý và bấm **Install**

<img src="/images/2.net45-2.png" />

Chờ khoảng 5-10p để quá trình cài đặt diễn ra.

<img src="/images/2.net45-3.png" />

Bấm **Finish** để hoàn thành quá trình cài đặt.

<img src="/images/2.net45-4.png" />

- **Bước 2:** Tải công cụ **Microsoft Web Platform Installer 5.0** (Web PI)
	
Link: https://www.microsoft.com/web/downloads/platform.aspx

<img src="/images/3.webpi1.png" />

- **Bước 3:** Chạy *Microsoft Web Platform Installer 5.0* - **wpilaucher.exe**

<img src="/images/3.webpi2.png" />

Sau khi khởi động xong, bấm vào tab **Products** để xem các gói cài đặt mà **Web PI** hỗ trợ .

<img src="/images/3.webpi3.png" />

<a name="2.3"> 

### 2.3  Cài đặt PHP và MySQL

Tại tab **Products** trong cửa sổ của **Web PI**, chúng ta cài đặt lần lượt PHP và MySQL.

- **Bước 1:** Cài đặt PHP

Gõ từ khóa **"PHP 5.5"** vào ô tìm kiếm của **Web PI**.

**Lưu ý**: Trong bài viết, chúng tôi sử dụng PHP phiên bản 5.5.

<img src="/images/4.php1.png" />

Bấm **Add** trên dòng **PHP 5.5.38**, Web PI sẽ tự động cài thêm cho chúng ta các phần bổ sung, đi kèm với PHP.

<img src="/images/4.php2.png" />

Bấm **Install** để cài đặt PHP

<img src="/images/4.php3.png" />

Bấm tiếp **I Accept** để đồng ý cài đặt.

<img src="/images/4.php4.png" />

Chờ 5-10p cho quá trình cài đặt diễn ra. Quá trình cài phụ thuộc vào tốc độ đường truyền của bạn!

<img src="/images/4.php5.png" />

Quá trình cài đặt hoàn tất, bấm **Finish** để đóng cửa sổ.
 
- **Bước 2:** Cài đặt MySQL

Gõ từ khóa **"mysql"** vào ô tìm kiếm của **Web PI**.

<img src="/images/5.mysql1.png" />

Chọn phiên bản **MySQL Windows 5.5**.

<img src="/images/5.mysql2.png" />

Nhập mật khẩu cho user `root` của MySQL

<img src="/images/5.mysql3.png" />

Bấm tiếp **I Accept** để đồng ý cài đặt.

<img src="/images/5.mysql4.png" />

Chờ 5-10p cho quá trình cài đặt.

<img src="/images/5.mysql5.png" />

Quá trình cài đặt hoàn tất, bấm **Finish** để đóng cửa sổ.

<img src="/images/5.mysql6.png" />

<a name="2.4"> 

### 2.4 Tạo pool ứng dụng PHP

- **Bước 1:** Mở IIS Manager > Chọn tên Server của bạn > Chọn tiếp **Application Pools** > **Add Application Pool...**

<img src="/images/6.addpool1.png" />

- **Bước 2:** Đặt tên cho Pool và chọn .NET Framework Version là **No Managed Code**

<img src="/images/6.addpool2.png" />

Bấm OK để lưu. Chúng ta thấy một Pool đã được tạo.

<img src="/images/6.addpool3.png" />

<a name="2.5"> 

### 2.5 Tạo và Phân quyền thư mục chứa mã nguồn Website

Tạo một thư mục mới tại ổ C là `www`, vào bên trong và chuột phải chọn **Properties**

<img src="/images/7.pq1.png" />

Chọn tab **Security** và bấm **Edit...**

<img src="/images/7.pq2.png" />

Bấm **Add...** để thêm User của IIS

<img src="/images/7.pq3.png" />

Gõ `IUSR`, bấm **Check Names** và chọn OK

<img src="/images/7.pq4.png" />

Chọn user `IUSR`, **Full controll**, OK, OK

<img src="/images/7.pq5.png" />

<img src="/images/7.pq6.png" />

<a name="2.6"> 

### 2.6 Tạo file test PHP 

Xóa tất cả file trong `C:\inetpub\wwwroot`, tạo một file có nội dung `index.php` và lưu tại thư mục

```
<?php
	phpinfo();
?>
```

Truy cập vào địa chỉ

```
http://localhost/
```

<img src="/images/8.test.png" />

<a name="3">

## 3. Kiểm tra

### 3.1 Kiểm tra MySQL

- **Bước 1:** Vào **Start** và tìm kiếm "*mysql client*"

<img src="/images/8.test-mysql1.png" />

- **Bước 2:** Nhập Mật khẩu của `root` vừa khai báo ở bên trên

<img src="/images/8.test-mysql2.png" />

- **Bước 3:** Thực hiện lệnh `show databases;` để xem tất cả Database có trên Server

<img src="/images/8.test-mysql3.png" />


<a name="4">

## 4. Tham khảo 

- https://docs.microsoft.com/en-us/iis/application-frameworks/scenario-build-a-php-website-on-iis/configuring-step-1-install-iis-and-php