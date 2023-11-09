# Message Queue
- Producer: Create new message and tranfer it to queue
- Consumer: `Poll` messages from queue then process it

# Simple Queue Service - SQS
- Simple Queue Service(SQS) là một dịch vụ hàng đợi thông điệp mạnh mẽ và dễ sử dụng từ AWS. SQS cho phép bạn truyền tin nhắn giữa các thành phần của hệ thống phân tán một cách đáng tin cậy và có khả năng mở rộng 
- Với SQS, có thể tạo ra các message queue và gửi/nhận message trên queue đó. Hàng đợi được quản lý bởi SQS, đảm bảo tính đáng tin cậy và khả năng mở rộng cao. Việc các ứng dụng khác nhau có gửi nhận mesage trên queue một cách độc lập giúp tăng tính chịu lỗi và sự phân tán trong hệ thống của bạn (de-coupling)
- SQS cung cấp 2 loại queue: standard & FIFO (First in first out). Standard queue cung cấp khả năng mở rộng cao và đáng tin cậy, trong khi FIFO queue đảm bảo tin nhắn được xử lý theo tuần tự (nhược điểm là bị giới hạn về tần suất gửi nhận)
- SQS cũng cung cấp các tính năng như chế độ retry tự động, message filtering và khả năng xác nhận( acknowledge) tin nhắn. Ngoài ra, SQS tích hợp với các dịch vụ AWS khác, cho phép xây dựng các hệ thống phức tạp và đáng tin cậy

# Tóm tắt SQS
- Fully Managed message queue service
- Use pull mechanism
- Các message được lưu cho đến khi được xử lý và xóa khỏi queue
- Đóng vai trò như 1 buffer đứng giữa producer và consumer
- Distributed Queue

# Loose Coupling with SQS
### Topology
- Tight coupling (Synchronous): A failure on the EC2 instance directly impacts the client
```
Client ----> EC2 instance
```

- Loose coupling(Synchronous): ELB routes traffic to only healthy EC2 instance, mitigating a failure on any one of them
```
                                         ---------> EC2 instance
                                         |
Client -----> Elastic LoadBalancing(ELB) ---------> EC2 instance
                                         |
                                         ---------> EC2 instance
```

- Loose coupling(Asynchronous):
    + EC2 instance "workers" pick up request as messages on the queue. If an failures occur, the message remains and another worker can process it (or it can receive special processing in a Dead Letter Queue)
    + If request rate exceeds the ability to process them, request can still be fulfilled as they are stored in queue until processed
```
                                    <====ReceiveMessage======
Client ----SendMessage--->   Queue  ======Message===========> EC2 instance                              
```

- Use `asynchronous processing` to get your responses from each step quickly
- Handle `performance and service requirements` by increasing the number of job instance
- Easily `recover from failed steps` because messages will remain in the queue

# SQS General Usecases
- Work queue
- Buffering batch operations
- Request offloading
- Trigger EC2 Auto Scaling

# Đặc trưng của SQS
- SQS là một managed service do đó bạn không quản lý hạ tầng phía sau
- SQS được tạo và quản lý dưói các đơn vị mesage queue
- Tương tác gửi nhận message với queue thông qua console, SDK, API
- Khả năng mở rộng SQS là không giới hạn
- Về cơ bản message nào được gửi vào queue trước sẽ được xử lý trước (khi có hành động get message). Tuy nhiên với Queue type standard, AWS không đảm bảo 100%
- Với FIFO Queue, SQS đảm bảo deliver đúng thứ tự tuy nhiên tần suất gửi nhận message bị giảm xuống 300/s và 3000/s đối với batch process
- SQS có thể được cấu hình notify message sang Lambda mỗi khi có message mới, sử dụng cho bài toán xử lý tự động ETL

# SQS Concepts
- Về cơ bản SQS là nơi có nhiệm vụ trung chuyển giữa một bên là message producer (sender) và một bên là message consumer (Receiver)
- Với Standard Queue, message khi được gửi vào queue sẽ tồn tại ở đó cho tới khi bị xóa hoặc hết thời gian retention. Do vậy Consumer phải chủ động xóa message đã xử lý xong
- Với FIFO Queue, message sẽ được delivery chính xác 1 lần tới consumer (tự động xóa sau khi có event receiver message)

# SQS Queue Type
- SQS cung cấp 2 loại queue: standard & FIFO (First in first out). Standard queue cung cấp khả năng mở rộng cao và đáng tin cậy, trong khi FIFO queue đảm bảo tin nhắn được xử lý theo tuần tự (nhược điểm là bị giới hạn về tần suất gửi nhận)

### 1. Standard queue
- At-least-one delivery
- Best-effort ordering: Xử lý ít nhất 1 lần và có thể xử lý nhiều lần
- Nearly unlimited throughput

### 2. FIFO(First In, First Out)
- First-in-first-out delivery
- Exactly once processing: Chỉ xử lý 1 lần
- High throughtput (throughput limit: 3000 messages per second with batching or 300 messages per second without batching)

# SQS Feature - Dead-letter Queue(DLQ)
- Lưu lại các message không thể xử lý thành công (Đẩy từ SQS queue -> Dead-letter queue)
- Rất hữu dụng trong việc debug
>DLQ không được tạo tự động, cần phải tạo SQS Queue khác đóng vai trò làm DLQ

# SQS Feature - Visibility Timeout
- Inflight messages: SQS message ở giữa khoảng thời điểm sau khi được consumer lấy từ queue và trường khi bị xóa khỏi queue -> một cách ngắn gọn: message đang được xử lý
- Visibility timeout: Khoảng thời gian mà SQS queue không trả về message đang được xử lý(inflight). Sau thời gian này, message có thể được một tiến trình khác xử lý
- SQS có một thông số gọi là Visibility Timeout, là thời gian message tạm bị ẩn đi đối với các consumer trong message đó đang được receive bởi một consumer. Quá thời gian này message chưa bị xóa sẽ quay trở lại queue
>vd: Việc không apply visibility time out (hoặc time out quá ngắn) trong trường hợp có nhiều consumer. Các consumer có thể get mesage đang được xử lý bởi một consumer khác (chưa finished)

- Việc apply Visibility Timeout như thế nào cho phù hợp hoàn toàn phụ thuộc vào nghiệp vụ.
>VD: Một tác vụ xử lý decode một video mất 10 mins thì nên để Visibility Timeout > 10 phút để tránh tình trạng xung đột xử lý giữa các consumer. Vì trong thời gian visibility timeout thì message đó đang được 1 consumer xử lý và nó sẽ bị ẩn cho đến khi hết visibility timeout thì consumer khác mới có thể access get vào được (Tránh xung đột giữa các consumer)

- Message mỗi khi được receive sẽ có một thông số receive count (được cộng lên +1 mỗi khi message đó được receive bởi 1 consumer), ta có thể dựa vào đó để setting dead letter queue( tự động move message đã bị xử lý quá số lần mà vẫn chưa thành công)

# SQS Feature - Long Polling & Short Polling
- Long Polling:
    + Query message trên toàn bộ server
    + Trả về truy vấn khi tìm thấy ít nhất một message. Hoặc empty response khi thời gian truy vấn timeout
    + Long polling wait time: Thời gian để SQS chờ trước khi return empty cho consumer trong trường hợp không có message nào trên queue
>Long polling waits for the WaitTimeSeconds and eliminates empty responses

- Short Polling:
    + Query message trên một vài server
    + Trả về truy vấn ngay lập tức, kể cả khi không tìm được message nào(sẽ nhận được nhiều empty message)
>Short polling checks a subnet of servers and may not return all messages

# SQS Message Lifecycle
### Mô hình
```
Producer ----send mesage ---> SQS  ----Receive message----> Consumer(xử lý)  ----Delete message after finished----> SQS
**Lưu ý: Ở cái đoạn delete message after finished thì đối với standard thì phải chủ động delete message queue, còn với fifo queue thì nó được tự động xóa sau khi event nhận message
```
### 1.Create
- Message được producer (component 1) đẩy vào SQS queue
### 2.Process
- Message được lấy và xử lý bởi consumer (component 2). Visibility timeout bắt đầu được tính cho message này
### 3.Delete
- Message được xóa sau khi hoàn thành việc xử lý (hoặc quá hạn retention period)
>SQS Retention period: Thời gian 1 message được tồn tại trong Queue. Có thể config từ 1 phút tới 14 ngày. Sau khoảng thời gian này nếu message không được xử lý thì nó sẽ bị xóa

# Decoupling Example
```
Elatic Load Balancing ---> Web tier ----> Order message ----> Customer order queue (if fail will tranfer to `Dead letter queue`) ----> Application tier  ---> Database tier(DB primary instance) ----> DB standby instance
```

# Một số giới hạn của SQS
- Giới hạn về số lượng message trên một queue: unlimited
- Queue name: 80 characters
- Queue tag: 50tag
- Long polling: 20s
- Message Visibility Timeout: min: 0s, max: 12 hours
- Message size max: 256kb
- Message attributes: 10 metadata attributes
- Message content: Có thể bao gồm XML, Json, Text
- Message retention: default 4 days, min: 1 minutes, max 14 days

# Một số thông số liên quan monitor
- Approximage age of oldest message: Thời gian của message cũ nhất đã được gửi vào queue
- Approximate number of message not visible: Số lượng message đang được xử lý (in-flight) nên bị tạm ẩn khỏi queue
- Approximate number of message visible: Số lượng message chưa được xử lý
- Number of message sent: Số lượng message đã được gửi
- Number of message received: Số lượng message đã được nhận
- Number of message deleted: Số lượng message đã bị xóa

# Usecase
- Đồng bộ dữ liệu giữa các hệ thống hoặc ứng dụng
- Xử lý hàng đợi giúp de-coupling hệ thống và chống bottle neck tại những component có thể có workload tăng đột ngột. Giúp chuyển từ xử lý đồng bộ sang bất đồng bộ
- Hệ thống xử lý thời gian thực bằng cách sử dụng FIFO queue
- Data migration. Ví dụ data từ source cần được chia ra nhiều luồng xử lý bất đồng bộ và có phương pháp retry cũng như phân loại message lỗi


# Pricing
- Tính tiền theo workload thực tế:
    + Số lượng request gửi nhận
        VD: $0.4/1 triệu request với standard và $0.5/1milion request với FIFO queue. Tính theo block 64Kb
    + Dữ liệu truyền từ SQS đi ra: $0.12/GB
>SQS: Zero idle cost
