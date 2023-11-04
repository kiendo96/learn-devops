# What is Lambda?
- Là 1 service serverless của AWS cho phép người dùng thực thi code mà không cần quan tâm tới hạ tầng phía sau
- Lambda hỗ trợ các ngôn ngữ (runtime) sau:
  + Java
  + Python
  + .NET
  + GO
  + Ruby
  + Custom Runtime
  + Container

## Đặc trưng
- Khi tạo 1 lambda function, bạn quyết định cấu hình thông qua số Memory. Min = 128MB, Max = 10GB. Memory càng cao, CPU được allocate càng lớn
- Lambda khi khởi chạy được cấp phát 1 vùng nhớ tạm min = 512MB, max = 10GB, sẽ bị xóa khi lambda thực thi xong
- Timeout tối đa 15 phút (quá thời gian này nếu execute chưa xong vẫn tính là failed và bị thu hồi resource)
- Lambda có thế được trigger từ nhiều nguồn: Trigger trực tiếp (Console or CLI), API Gateway, event từ các service khác(S3, SQS, DynamoDB, Kinesis, IoT...) hoặc chạy theo lịch (trigger từ EventBridge)
- Lambda có 2 mode chạy là chạy ngoài VPC và chạy trong VPC. Thông thường nêu lambda cần kết nối với RDS database thì nên để trong VPC (Lưu ý đến số lượng IP của subnet chưa lambda)
- Lambda sau khi chạy xong sẽ không lưu lại bất cứ gì
  + Log > CloudWatch log
  + File output -> S3 hoặc EFS
  + Data output -> RDS Database hoặc DynamoDB
- Lambda cũng cần được cấp IAM Role để có thể tương tác với các resource khác. Mặc định Lambda khi tạo ra sẽ được gán Role có các quyền cơ bản (VD: Write log to CloudWatch)
- Lambda không chỉ chứa 1 file code mà có thể chứa các file library, file common,... Để tiện dụng ta có thể gom nhóm chúng lại thành các layer và tái sử dụng ở nhiều function, tránh duplicate code
- Khi có nhiều request từ client, Lambda scale horizontal bằng cách gia tăng số lượng concurent execute. Giới hạn này mặc định khi tạo account AWS là 10 concurent executions. Cần request tăng số này lên trước khi release production
- Lambda có thể được set một số reserve concurent để tránh bị ảnh hưởng bởi các lambda khác

## Lambda Pricing
- Lambda là 1 dịch vụ có idle cost = 0. Người dùng chỉ trả tiền cho chi phí chạy thực tế, cụ thể:
  + Thời gian execute của lambda. Đơn vị GB* second
      VD: Singapore price: $0,0000167/GB*second
  + $0.2/1 millions requests
VD: Có 1 lambda 512MB memory, mỗi request chạy trong 5s, 1 tháng có 100000 request
  => 250000GB*second = $4.175
  => (250000/1000000)*0.2 = %0.05
  Total: $4.225

## Hệ sinh thái Lambda
- Lambda là 1 service có thể liên kết với gần như tất cả các service khác của AWS, miễn là nó được cấp IAM role phù hợp
VD: CloudWatch, RDS, S3, DynamoDB, API Gateway, SNS, Kinesis, IoT, SQS, EventBridge....

## Ưu điểm của Lambda
- Không tốn effort cho quản trị hạ tầng, High Availability
- Zero idle cost. Do lambda chỉ phát sinh chi phí khi chạy, nếu hệ thống không phát sinh nhu cầu sử dụng -> cost gần như bằng zero
- Kết hợp được với nhiều service của AWS
- Khả năng scale mạnh mẽ (Bằng cách nhân bản số lượng concurrent)
- Support nhiều ngôn ngữ
- Dễ dàng triển khai bằng tool do AWS phát hành hoặc 3rd party

## Nhược điểm
- Cold start: Code cần thời gian để nạp lên memory trước khi thực sự bắt đầu chạy (Gần đây đã được cải thiện vấn đề này rất nhiều)
- Giới hạn về bộ nhớ: 10GB. Không phù hợp cho các tác vụ nặng
- Khó tích hợp. Hệ thống để deploy lên lambda cần chia nhỏ do đó làm tăng tính phức tạp và khó debug
- Giới hạn về thời gian chạy, max 15minute. Không phù hợp với các tác vụ tính toán tốn thời gian
- Không lưu lại trạng thái sau khi chạy. Cần có external storage, database, logging


## Các trường hợp nên sử dụng lambda
+ Tác vụ automation trên AWS, nhận trigger từ các AWS service như S3, DynamoDb, SNS, SQS...
+ Backend cho API hoặc IOT
+ Xử lý data trong bài toán data ETL
+ Hệ thống có kiến trưc microservice nói chung
+ Công ty startup muốn tối ưu cost cho giai đoạn bắt đầu

## Những usecase không nên sử dụng lambda
+ Hệ thống Monolithic (do source code quá nặng) hoặc team không có kinh nghiệm phát triển microservice
+ Xử lý dữ liệu lớn, phân tích, tổng hợp data (hoặc chạy nhiều hơn 15p)
+ Machine Learning.

# Các use case thường sử dụng Lambda
### Dùng làm backend API khi kết hợp với API Gateway
- Topo Example:
```
Client => API Gateway => Backend Lambda ===CRUD===> DynamoDB & RDS
                         Backend Lambda --- log/metrics ---> CloudWatch
            API Gateway -> Authorizer Lambda
```

-  Trong topo này: 
  + Client nó sẽ gửi 1 request đến API gateway và thằng API gateway nó sẽ sử dụng Lambda để làm authorized xem client có quyền access hay không.
  + Sau khi kiểm tra hoàn tất thì thằng API gateway nó sẽ forward request của client đến thằng Backend Lambda => backend lambda sẽ được sử dụng để tương tác với DB như (DynamoDB và RDS) => Sau khi nó tương tác với DB thì log của lambda sẽ được chuyển đến cloudWatch -> Sau đó nó sẽ trả lại thông tin cho client




### Thực hiện các tác vụ đơn giản theo lịch kết hợp với EventBridge
- Topo Example
```
  EventBridge ----- scheduler ------> Lambda     ---- start/top ---> EC2
              ----- event ----------> Lambda     ---- notification ----> SNS
```
- Trong topo này: Khi cần thực hiện 1 số tác vụ với Ec2 thì có thể sử dụng EventBridge và lambda để bật tắt server theo lịch  -> Khi thành công lambda sẽ gửi 1 sns to SNS service

### Xử lý Async khi nhận trigger từ S3

- Topo Exam:
```
  S3 Source ---Trigger when upload ---> Lambda ---- transform --> S3 destination
                                               ---- save metadata ----> DynamoDB
                                               ---- save metadata ----> RDS
```
- Trong đó:
  + Chúng ta có 1 s3 source. Khi user cần upload 1 file lên bucket này. Ví dụ như ảnh, file pdf... ==> Để giảm tải dung lượng của ảnh chẳng hạn, thì khi user upload ảnh vào bucket này thì nó sẽ được trigger to Lambda
  + Lambda sẽ thao tác với file trên bucket S3 -> VD: Bóp ảnh, giảm dung lượng, chỉnh sửa độ phân giải  ==> Sau đó Lambda sẽ đẩy S3 sau khi đã xử lý vào 1 bucket S3 destionation => Cuối cùng nó sẽ save metadata đó vào DB


### Xử lý sync khi nhận trigger từ DynamoDb
- Topo Example:
```
Client ---request -----> API GateWay ---> DynamoDB ---- Trigger when create/modify ----> Lambda --- save data --> DynamoDB or RDS
```

- Trong đó:
  + Khi client tương tác với API Gateway và tác động sẽ được lưu thẳng vào DynamoDB thì sau đo ===> hành động create/modify đó sẽ được trigger qua lambda ===> Sau đó lambda mới xử lý và lưu vào DynamoDB hoặc RDS


## Một số thông số quan trọng của S3 configuration
> Create lambda function => Access table "configuration"
- Edit "General configuration"
  + Memory: Có thể set memory tối đa 10GB và memory càng nhiều thì CPU càng lớn (ko thể set CPU)
  + Ephemeral storage(/tmp): Ổ đĩa tạm thời. Có thể config tối đa lên 10GB
  + Timeout: Set thời gian timeout để cho function có thể xử lí.
  >VD: Nếu để timeout mặc định là 3s thì khi function xử lý ảnh mất 10s thì function sẽ không thể successfully

- Excution role: Setting role phù hợp để cấp quyền cho Lambda có thể thực thi.
  >VD: Cấp quyền cho lambda có thể access vào S3 bucket

- Trigger
  + Sử dụng để add trigger từ resource khác qua lambda
  >VD: S3 -> Lambda, DynamoDB -> Lambda, API gateway -> Lambda

- Funtion URL:
  + Create 1 url để client có thể access thực thi function bằng function url này
- Environment variables: 
  + Để custom biến môi trường.
  > VD: Cùng 1 resource nhưng có thể dùng được ở nhiều môi trường khác nhau

- VPC:
  + Nếu Lambda cần tương tác với database thì để đảm bảo security nên sử dụng local VPC để cho lambda tương tác với database
- Concurrency: 
  + Số lượng xử lý đồng thời của lambda
- Asynchronous invocation: 
  + Dùng với nodejs chẳng hạn. Chưa hiểu lắm
- Lambda có thể set alias thay vì dùng ARN
- Lambda có thể quản lý code theo version
