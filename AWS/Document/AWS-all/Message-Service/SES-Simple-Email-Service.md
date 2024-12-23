# Simple Email Service (SES)
- SES là một dịch vụ email được cung cấp bởi Amazon Web Services (AWS) để gửi và nhận email một cách đáng tin cậy và có hiệu suất cao

# SES - Tính năng
### 1. Gửi email
- SES cho phép bạn gửi email từ ứng dụng hoặc hạ tầng đám mây của bạn thông qua giao thức SMTP (Simple mail Transfer Protocol)
### 2. Quản lý danh sách người nhận
- SES cho phép bạn quản lý và lưu trữ danh sách người nhận email của bạn
### 3. Xác thực và bảo mật
- SES cung cấp các tính năng xác thực và bảo mật nhằm bảo đảm rằng email của bạn được gửi từ nguồn đáng tin cậy và không bị làm giả mạo. Điều này bao gồm xác thực thông qua DKIM (DomainKeys Identified Mail), SPF (Sender Policy Framework) và DMARC (Domain-based Message Authentication, Reporting and Conformance)
### 4. Ghi lại hoạt động
- SES cung cấp các log chi tiết về hoạt động gửi email, bao gồm thông tin về người gửi, người nhận, thời gian gửi và kết quả gửi. Bạn có thể sử dụng dữ liệu này để theo dõi và phân tích hiệu suất gửi email
```
- SES có thể được tích hợp với các dịch vụ khác trong mạng lưới AWS, như lambda, S3 và SNS để tự động hóa quy trình gửi email và xử lý các hành động phản hồi từ người nhận.
- Lưu ý rằng SES chủ yếu là dịch vụ gửi email và có giới hạn về tính năng nhận email. Nếu bạn cần chức năng đầy đủ để nhận và xử lý email, bạn có thể xem xét sử dụng dịch vụ như Amazon Simple Notification Service (SNS) hoặc Amazon WorkMail
```

# SES - Pricing
- Số lượng email: $0.1/1000 email
- File đính kèm: $0.12/1GB attachment
- Ngoài ra SES còn tính phí thêm cho các option như Dedicated IP, Virtual Deliverability Manager
