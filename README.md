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


#### Một số kiểu bản tin HTTP Method
| TÊN | MÔ TẢ |
|---|---|
|**GET**| Gửi yêu cầu để lấy một tài nguyên nào đó trên máy chủ.|
|**POST**| Đưa thông tin lên server.|
|**PUT**| Lưu trữ các dữ liệu, thông tin dưới dạng URL |
|**DELETE**| Xóa các URL đã lưu ở PUT |
| **HEAD**| Lấy ra thông tin ở dữ liệu bên trong URL |
| **TRACE**| Xem bản tin, dữ liệu đi qua bao nhiêu máy chủ |

#### REQUEST HEADER

Một số trường cần chú ý

| Tên trường | Mô tả |
|---|---|
|Accept | Loại nội dung có thể nhận từ thông điệp Response. VD: css, js,...|
| Accept-Encoding| Chấp nhận các kiểu file nén|
|Connection| Tùy chọn điều khiển cho kết nối hiện thời. VD: Keep-alive, Upgrade,...|
|Cookie| Thông tin HTTP Cookie từ server|
|User-Agent| Thông tin về người dùng, tên trình duyệt sử dụng...|


#### RESPONSE METHOD

Là những bản tin server trả về client những thông tin mà client yêu cầu từ gói REQUEST trước.

<img src="http://img.prntscr.com/img?url=http://i.imgur.com/vgEG4Qz.png" />

Một vài mã phổ biến mà chúng ta hay gặp:

|Mã số| Loại | Mô tả|
|---|---|---|
|1xx| Informational| Lắng nghe các yêu cầu và tiếp tục xử lý|
|2xx| Success | Bản tin báo hiệu kết nối và yêu cầu thành công|
|3xx| Forwarding | Client sẽ được thông báo chuyển tiếp tới URL khác |
|4xx| Client errors| Thường là nhập sai URL, hoặc file, trang bị xóa trên server|
|5xx|Server Errors | Server bị lỗi nên không thể tiếp nhận các request từ client|

Cụ thể các mã như sau:

##### 1xx Informational

- **100 Continue**: Server nhận các request header, client xử lý để gửi các request body. Nếu các request body quá lớn được gửi tới server mà server chưa xử lý kịp và sẽ bị từ chối, khi đó client gửi mã trạng thái này lên.
- **101 Switching Protocol**: Requester hỏi server về các giao thức định tuyến, server sẽ chấp thuận.
- **102 Processing**: Server đang xử lý các yêu cầu mà chưa kịp trả lời cho client.

##### 2xx Success

- **200 OK**: Thành công.
- **201 Created**: Đã khởi tạo thành công.
- **202 Accepted**: Đã được chấp thuận.
- **203 Non-Authoritative Information**: Khôn g yêu cầu thông tin xác thực
- **204 No content**: Đã xử lý thành công nhưng server không trả về bất cứ nội dung nào.
- **205 Reset Content**: Yêu cầu làm mới nội dung khi nhận được 204.
- **206 Partial Content**: Nhận được nội dung nhưng không đầy đủ.
- **207 Multi-Status**: Đa trạng thái, nhận nhiều trạng thái trả về cùng một lúc
- **208 Already Reported**: Đã gửi các yêu cầu nhưng chưa thấy trả lời.
- **226 IM Used**: Server đã nhận được đầy đủ các request.

##### 3xx Redirection

- **301 Moved Permanently**: Luôn chuyển tiếp
- **302 Found**: Khi client yêu cầu, server sẽ tìm và chuyển tiếp nếu tìm thấy hoặc hợp lệ
- **303 See other**: Khi nhận được các phương thức POST, PUT hoặc DELETE, client coi như server đã nhận được và chuyển tiếp với thông điệp GET.
- **305 Use Proxy**: Sử dụng proxy 

##### 4xx Client Errors

- **400 Bad Request**: Server không thể xử lý các request từ client như sai cú pháp, site đường dẫn,...
- **403 Forbidden**: Không có quyền xem
- **404 Not Found**: Request các nội dung có từ trước nhưng đã bị gỡ bỏ.
- **408 Request Timeout**: Request của client quá thời gian, hoặc do kết nối của client có vấn đề

##### 5xx Server Errors

- **500 Internal Server Error**: Lỗi máy chủ nội bộ
- **502 Bad Gateway**: Gateway hoặc proxy của server bị lỗi
- **503 Service Unavailable**: Dịch vụ chưa sẵn sàng

Trên đây là một số lỗi thường gặp, để xem chi tiết vui lòng bấm vào <a href="https://en.wikipedia.org/wiki/List_of_HTTP_status_codes" target="_blank" >đây</a>.

#### CACHE

- Là bộ lưu trữ tạm thời những trang, những bài viết,... đã được Client truy cập trước đó
- Mục đích của cache là giảm thời gian, tài nguyên của client và server khi muốn truy cập lại những gì đã từng truy vấn tới server

#### COOKIE

- Là tập tin chứa những dữ liệu người dùng được Server ghi lại và gửi về client
- Thường được sử dụng trên các website dạng forum hoặc thương mại điện tử, có lượng truy cập cao và cơ sở dữ liệu lớn
- Sau một thời gian nhất định, cookie sẽ được xóa

