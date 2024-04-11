# Permission in Jenkins

**Nhóm đặc quyền 1: Overall**

- Administrator – Quyền này cấp cho khả năng thực hiện các thay đổi cấu hình trên toàn hệ thống, cũng như thực hiện các hoạt động có độ nhạy cao tương đương với toàn quyền truy cập hệ thống cục bộ (trong phạm vi được cấp bởi Hệ điều hành cơ bản.)
- ConfigureUpdateCenter – Quyền này cho phép người dùng định cấu hình các trang cập nhật và cài đặt proxy
- Read – Quyền đọc là cần thiết để xem hầu hết các trang của Jenkins. Quyền này hữu ích khi bạn không muốn người dùng chưa được xác thực xem các trang của Jenkins: thu hồi quyền này từ người dùng ẩn danh, sau đó thêm authenticated người dùng giả và cấp quyền truy cập đọc.
- RunScripts – Bắt buộc để chạy các tập lệnh bên trong quy trình Jenkins, ví dụ thông qua bảng điều khiển Groovy hoặc lệnh Groovy CLI.
- UploadPlugin – Quyền này cho phép người dùng tải lên các plugin tùy ý

**Nhóm đặc quyền 2: Credential**

- Create – Quyền tạo là cần thiết để thêm thông tin đăng nhập vào nhà cung cấp thông tin xác thực.
- Delete – Quyền xóa là cần thiết để xóa thông tin đăng nhập được lưu trữ trong nhà cung cấp thông tin xác thực.
- Manage Domains – Quyền quản lý miền là cần thiết để thêm / xóa / định cấu hình miền thông tin xác thực của nhà cung cấp thông tin xác thực (trong đó nhà cung cấp thông tin xác thực hỗ trợ nhiều miền thông tin xác thực).
- Update – Cần có quyền cập nhật để sửa đổi thông tin xác thực trong nhà cung cấp thông tin xác thực.
- View – Quyền xem là cần thiết để xem thông tin xác thực được lưu trữ trong nhà cung cấp thông tin xác thực.

**Nhóm đặc quyền 3: Agent**

- Build – Quyền này cho phép người dùng thực hiện các Job như họ trên các đại lý.
- Configure – Quyền này cho phép người dùng định cấu hình agent.
- Connect – Quyền này cho phép người dùng kết nối đại lý hoặc đánh dấu đại lý là trực tuyến.
- Create – Quyền này cho phép người dùng tạo agent.
- Delete – Quyền này cho phép người dùng xóa các agent hiện có.
- Disconnect – Quyền này cho phép người dùng ngắt kết nối agent hoặc đánh dấu agent là tạm thời ngoại tuyến.

**Nhóm đặc quyền 4: Job**

- Build – Quyền này cấp khả năng bắt đầu bản dựng mới.
- Cancel – Quyền này cấp khả năng hủy bỏ một bản đã lên lịch hoặc hủy bỏ một bản dựng đang chạy.
- Configure – Thay đổi cấu hình của một Job.
- Create – Tạo một Job mới.
- Delete – Xóa Job.
- Discover – Quyền này cho phép khám phá quyền truy cập vào Job. Thấp hơn quyền đọc, nó cho phép bạn chuyển hướng người dùng ẩn danh đến trang đăng nhập khi họ cố gắng truy cập url Job. Nếu không có nó, họ sẽ gặp lỗi 404 và không thể phát hiện ra tên dự án.
- Read – Xem một Job. (Bạn có thể từ chối quyền này nhưng cho phép Khám phá buộc người dùng ẩn danh đăng nhập để xem Job.)
- Workspace – Quyền này cấp cho khả năng truy xuất nội dung của không gian làm việc mà Jenkins đã kiểm tra để thực hiện các bản dựng. Nếu bạn không muốn người dùng truy cập các tệp trong không gian làm việc (ví dụ: mã nguồn được kiểm tra từ SCM hoặc kết quả xây dựng trung gian) thông qua trình duyệt không gian làm việc, bạn có thể thu hồi quyền này.

**Nhóm đặc quyền 5: Run**

- Delete – Quyền này cho phép người dùng xóa thủ công các bản dựng cụ thể khỏi lịch sử bản dựng.
- Replay – Khả năng thực hiện một bản dựng Đường ống mới với một tập lệnh đã chỉnh sửa.
- Update – Quyền này cho phép người dùng cập nhật mô tả và các thuộc tính khác của một bản dựng, chẳng hạn như để lại ghi chú về nguyên nhân gây ra lỗi bản dựng

**Nhóm đặc quyền 6: View**

- Configure – Quyền này cho phép người dùng thay đổi cấu hình chế độ xem.
- Create – Quyền này cho phép người dùng tạo chế độ xem mới.
- Delete – Quyền này cho phép người dùng xóa các chế độ xem hiện có.
- Read – Quyền này cho phép người dùng xem các chế độ xem (ngụ ý bởi quyền truy cập đọc chung).

**Nhóm đặc quyền 7: SCM**

- Tag – Quyền này cho phép người dùng tạo một thẻ mới trong kho mã nguồn cho một bản dựng nhất định.
