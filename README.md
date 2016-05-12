#Tổng quan về HTTP

### 1. Khái niệm về HTTP

**HTTP** viết tắt của **Hypertext Transfer Protocol**, tạm dịch là **Giao thức truyền siêu văn bản** dùng để truyền tải các nội dung như văn bản, các dịch vụ đa phương tiện (video, âm thanh, hình ảnh,...)
- Là nền móng của truyền thông dữ liệu cho WWW
- Hoạt động theo mô hình Client-Server

### 2. Mô hình hoạt động

Như đã giới thiệu ở phần trên, HTTP hoạt động theo mô hình client-server. Client ở đây cụ thể là một trình duyệt WEB (Web-browers) và Server là một máy có cài đặt một phần mềm cho phép các client truy cập vào qua cổng mặc định là 80.

<img src="http://www.bloggedbychris.com/wp-content/uploads/2013/10/image004.png" />

#### REQUEST METHOD

Là những bản tin được gửi đi từ Client đến Server.

<img src="http://img.prntscr.com/img?url=http://i.imgur.com/UEypQ2Z.png" >

#### RESPONSE METHOD

Là những bản tin server trả về client những thông tin mà client yêu cầu từ gói REQUEST trước.

<img src="http://img.prntscr.com/img?url=http://i.imgur.com/vgEG4Qz.png" />

#### Một số HTTP Menthod
| TÊN | MÔ TẢ |
|---|---|
|**GET**| Gửi yêu cầu để lấy một tài nguyên nào đó trên máy chủ.|
|**POST**| Đưa thông tin lên server.|
|**PUT**| Lưu trữ các dữ liệu, thông tin dưới dạng URL |
|**DELETE**| Xóa các URL đã lưu ở PUT |
| **HEAD**| Lấy ra thông tin ở dữ liệu bên trong URL |
| **TRACE**| Xem bản tin, dữ liệu đi qua bao nhiêu máy chủ |


