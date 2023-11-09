# Simple Notification Service - SNS
- AWS Simple Notification Service (SNS) là một dịch vụ notification, cho phép bạn gửi thông báo đến các đối tượng khác nhau như các ứng dụng, user, hệ thống hoặc các dịch vụ khác trên AWS
- SNS cho phép gửi thông báo bằng nhiều phương thức khác nhau như email, SMS, push notification hoặc API CALL. Có thể tạo và quản lý các topics trong SNS và sau đó gửi thông báo đến các chủ đề đó. Các đối tượng đã đăng ký (subsribed) vào chủ đề sẽ nhận được thông báo

# Đặc trung của SNS
- Về cơ bản SNS hoạt động theo mô hình Publisher - Subscriber, message khi được bên publisher gửi lên SNS topic sẽ được đồng loại gửi tới các subscriber
- Đa kênh thông báo: SNS hỗ trợ nhiều kênh thông báo như email, SMS, push notification (như thông báo trên mobile) và API call
- Khả năng mở rộng và đáng tin cậy: SNS xử lý việc phân phối thông báo trên cơ sở hạ tầng mở rộng của AWS. Nó tự động xử lý khả năng mở rộng và đảm bảo tính đáng tin cậy của việc gửi thông báo
- Tích hợp với các dịch vụ AWS khác: SNS tích hợp tốt với các dịch vụ AWS khác như SQS, CloudWatch, AWS Lambda, Amazon EC2 và nhiều dịch vụ khác. Điều này cho phép xây dựng các hệ thống phức tạp và tự động hóa quá trình gửi thông báo
- SNS có hỗ trợ FIFO tương tự như SQS
- Message attribute cho phép lưu trữ thêm những thông tin tùy chọn cho message
- Message Filtering: Cho phép đặt các filter để quyết định xem message sẽ notify tới các subscriber nào
- Message security: Kết hợp với KMS để mã hóa message, tăng tính bảo mật


# SNS concepts
- SNS có thể kết hợp được với nhiều dịch vụ khác nhau trên AWS cũng như notify tới nhiều loại target bên ngoài AWS
VD: SNS topic có thể notify:
    + SQS
    + Email
    + HTTP
    + Lambda
    + SMS
    + Kinesis
    + other application
    SNS topic nhận từ nguồn publish
    + Publisher
    + Lambda
    + Alarm

# SNS limitation
- Số lượng topic/account: 100000, FIFO: 1000
- Subscription: 12500000/topic. FIFO: 100/topic
- Delivery rate for email: 10 message/s (extend able)
- Message size: 256Kb

# SNS usecase
- Notify đến email/SMS trong trường hợp dùng làm notification service
- Kết hợp với các dịch vụ Monitoring, Audit, Security để thông báo tới người phụ trách
- Notify tới Mobile Application
- Gửi notification đồng thời tới nhiều target theo thời gian thực
- Xây dựng hệ thống phân tán
- Xây dựng hệ thống chat

# SNS pricing
- Cost cho việc gửi notification
    + Mobile push: $0.5 per 1M notification
    + Email: $1 per 1M notification
    + HTTP: $0.6 per 1M notification
- Data transfer
    + Transfer in: Free
    + Transfer out: $0.12/GB
- Chi phí cho SMS: tùy thuộc vào quốc gia
- Message filter: $0.11/GB payload data được scan