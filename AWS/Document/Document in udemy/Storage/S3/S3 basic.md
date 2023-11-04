## What is S3
- Viết tắt của Simple Storage Service
- Là một dịch vụ lưu trữ dạng Object cung cấp khả năng mở rộng, avaibility, performance
- KH có thể sử dụng S3 để lưu trữ và bảo vệ nhiều loại data cho các usecase như: data lake, website, mobile, backup & storage, archive, enterprise application, IoT device, Big Data & Analytic
- S3 cung cấp nhiều managed feature giúp tối ưu, tổ chức và cấu hình access tới data đáp ứng nhu cầu về business, organization & complicance

## Đặc trưng cơ bản của S3
- Là một Managed Service. User không cần quan tâm tới hạ tầng ở bên dưới
- Cho phép lưu file dưới dạng object với size từ 0-5TB
- High Durability (11 9s), Scalability, High Availability(99.99%), High performance
- Usecase đa dạng (mọi bài toán về lưu trữ từ lớn tới nhỏ đều sử dụng S3)
- Cung cấp nhiều class lưu trữ để tiết kiệm chi phí cho từng loại data
- Cung cấp khả năng phân quyền và giới hạn truy cập một cách chi tiết
- Dễ sử dụng, có thể kết hợp với nhiều service khác cho bài toán automation và data processing

## Features of S3
- S3 cung cấp các tính năng cơ bản sau:
  + Storage classes: cung cấp nhiều hình thức lưu trữ phù hợp cho nhiều loại data khác nhau về nhu cầu access, yêu cầu durability thời gian lưu trữ khác nhau giúp KH tùy chọn được class lưu trữ phù hợp từ đó tối ưu chi phí
  + Storage management: Cung cấp nhiều tính năng liên quan quản lý như: Life Cycle, Object Lock, Replication, Batch Operation
  + Access Management: Quản lý truy cập đến bucket và các thư mục thông qua cơ chế resource permission & access list. Block public access via IAM, bucket policy, S3 access point, Access Control List, Ownership, Access Analyzer
  + Data processing: kết hợp vói lambda, SNS, SQS để hỗ trợ xử lý data 1 cách nhanh chóng
  + Auto logging and Monitoring: Cung cấp công cụ monitor S3 bucket và truy vết sử dụng CloudTrail
  + Manual Monitoring Tool: Log lại từng record thực hiện trên bucket
  + Analytic and insight: phân tích storage để optimize
  + Strong consistency: Provice strong read-after-write consistency for PUT and DELETE object

## Các ví dụ nỗi bật thường sử dụng với S3
- [VPC, ALB, API GW]         -> Write log -> S3
- IoT                        -> save File -> S3
- [ECS, EC2]                 -> File storage -> S3
- Backup                     -> backup file -> S3
- [CloudWatch, CloudTrail]   -> Log Archive -> s3
- S3                         -> static web hosting -> CloudFront
- S3                         -> Automation process -> Lambda
- S3                         -> Data source > Glue

## S3 có thể kết hợp với các dịch vụ nào
- Dùng làm nơi lưu trữ file cho các ứng dụng chạy trên EC2, Container, Lambda. Các file có thể đa dạng về loại & kích thước (Image, Video, Document)
- Dùng làm nơi chứa/archive log cho hầu hết các dịch vụ khác của AWS(VPC, ALB, APIGateWay..)
- Dùng làm data source cho các bài toán big data & data ware house
- Nơi lưu trữ dữ liệu gửi lên từ các thiết bị IoT
- Vùng lưu trữ tạm thơi cho bài toán ETL ( Extract - Transform - Load) khi kết hợp với lambda
- Host 1 website tĩnh (Html, CSS, JS) khi kết hợp với CloudFront


## S3 Bucket Policy
- S3 là một trong số các resource có hỗ trợ Resource Level Policy để giới hạn quyền truy cập bên cạnh IAM Policy 
- Bản chất S3 bucket policy hoạt động như 1 IAM policy nhưng chỉ trong phạm vi bucket và những resource bên trong nó (folder/file)
- S3 bucket policy sẽ cho phép (allow) hoặc chặn (Deny) truy cập tới bucket hoặc các resource bên trong
- Áp dụng cho những bucket yêu cầu security cao, cần được setting giới hạn truy cập một cách chặt chẽ

# Access control list
- Access Control List: Quy định quyền access của một AWS Account hoặc nhóm user (Group) đến bucket hoặc resource bên trong
- Thường dùng trong trường hợp muốn cấp access cho một resource cụ thể bên trong bucket mà không muốn thay đổi bucket policy
- *Gần đây AWS khuyến nghị người dùng không nên xài ACL trừ khi có yêu cầu đặc biệt, thay vào đo hãy sử dụng bucket policy & pre-sign URL là đủ để cover hầu hết các usecase

# S3 versioning
- Sử dụng khi có nhu cầu lưu trữ nhiều version của cùng 1 object
- Tránh được việc mất mát khi tao tác xóa nhầm hoặc ghi đè ( Có thể lấy lại version trước đó)
- Chi phí theo đó sẽ tăng lên so với khi không bật versioning
- Sau khi bật versioning, nếu tắt versioning thì những object trước khi tắt vẫn sẽ có nhiều version, những object sinh sau khi tắt sẽ không có version

# S3 Presign URL
- Khi muốn cấp access tạm thời cho người dùng public tới một object trên S3, AWS cung cấp cơ chế Presign URL
- User có thể dùng Presign URL để dowload/upload object trên s3 trong thời gian quy định (setting lúc phát hành URL)
- Usecase:
  + Muốn cấp access public cho 1 object nhưng không muốn thay đổi ACL hoặc tạo thêm bucket policy
  + Cần authen người dùng hoặc yêu cầu họ làm gì đó trước khi được download file (VD xem quảng cáo)
  + Ngăn chặn resource để public vô thời hạn khiến cho tài nguyên bị khai tác bởi bên khác
*Example flow of S3 Presign URL trong thực tế
Request:
1. Request file -> [Backend server] -> 2.Request Presign URL -> [S3] -> 3.Create Presign URL -> xxx-bucket -> Object
Response:
4. S3 -> Return Presign URL -> Backend Server -> 5.Return URL -> Client -> 6.Client download via internet trực tiếp tới S3

# S3 Storage Classes
- S3 cung cấp nhiều storage class khác nhau nhằm giúp người dùng linh động trong việc lựa chọn class phù hợp với nhu cầu, tiết kiệm chi phí
- Việc lựa chọn class phụ thuộc vào các yếu tố như:
  + Durability, High Availability
  + Thời gian lưu trữ (1 tháng, 1 năm, 5 năm ...)
  + Tần suất truy cập, thời gian cần có file khi có yêu cầu
  + Mục đích sử dụng: Document, image, log file, backup file, archive
- S3 Standard: Chuẩn storage class mặc định khi tạo object mà không chỉ định classes. Phù hợp cho hầu hết các usecase
- S3 Intelligent Tiering: Monitor tần suất access của các object một cách tự động để move xuống các class rẻ tiền hơn giúp tiết kiệm chi phí. Chỉ apply cho object >= 128Kb. KH phải chịu thêm phí monitor
- S3 standard infrequently access (Standard IA): Phù hợp cho các data ít khi được access nhưng khi request cần có ngay. Availability 99.9% (nhỏ hơn standard 99.99%)
- S3 One-Zone infrequently access (One Zone IA): rẻ hơn standard IA 20% do chỉ lưu trữ trên 1 AZ. Phù hợp cho các data có thể dễ dàng tạo ra nếu không may bị mất (report, file image resized). Availability 99.5%)
- S3 Glacier: Phù hợp cho việc lưu trữ những data có yêu cầu thời gian lưu trữ lên tới vài năm nhưng ít khi được sử dụng. Tùy theo nhu cầu khi access mà Glacier lại chia ra 1 số sub class:
  + Glacier Instant Retrieval: rẻ hơn tới 68% so với S3 Standard IA. Cho phép access 1 file với thời gian ngắn khi có nhu cầu. VD hồ sơ phim chụp của bệnh nhân ở bệnh viện ít khi cần lục lại muốn xem phải có ngay
  + Glacier Flexible Retrieval (Normal Glacier): phù hợp cho data không yêu cầu access ngay hoặc chưa rõ, thời gian cần để access file có thể từ vài phú tới vài giờ. Phù hợp cho việc lưu data backup hoặc archive
  + Glacier Deep Archive: Phù hợp cho việc lưu trữ lâu dài lên tới 7-10 năm tùy theo tiêu chuẩn ngành như tài chính, y tế, ... data được lưu trên các băng đĩa từ (magnetic tap). AWS cam kết có thể access data trong vòng 12h khi cần
- S3 on Outposts:Cho phép sử dụng S3 ở on-premise

## S3 Life Cycle:
- Tính năng cho phép tự động move object xuống các class lưu trữ thấp hơn hoặc xóa luôn sau một khoảng thời gian nhằm tiết kiệm chi phí
- Khác với Intelligent Tiering, người dùng sẽ tự quyết định life cycle cho objects (hoặc 1 thư mục)
  VD: sau 90 ngày thì cho xuống Glacier, sau 270 ngày thì xóa hoàn toàn
- Phù hợp cho các bài toán lưu trữ Log đã biết trước thời gian thường xuyên access và thời gian có thể xóa

## S3 Static Website hosting
- S3 có hỗ trợ người dùng host 1 website tĩnh (chỉ bao gồm html, css, js, image ...)
- Được thừa hưởng toàn bộ đặc tính của S3 (Durability, HA)
- Không cần duy trì server, giảm effort Administrator
- Hỗ trợ setting CORS nhằm tránh tài nguyên bị khai thác bởi website khác
- Kết hợp với dịch vụ CDN(Cloud Front) có thể giúp tăng tốc độ truy cập khi user nằm ở các region khác nhau
=> Hầu hết các framework frontend hiện nay như Angular, Vue, Nodejs đều hỗ trợ build ra 1 website tĩnh để có thể deploy lên S3 sau khi code xong


## S3 event trigger
- Cung cấp cơ chế trigger 1 event sang dịch vụ khác khi có thay đổi đối với object(upload, delete)
- Target của trigger có thể là lambda function, SNS, SQS
- Sample usecase
  + Resize image khi có người upload image lên S3 bucket, lưu vào các thư mục size khác nhau
  + Giải nén 1 file zip khi có người upload
  + Extract csv file, xử lý data rồi lưu vào database
  + Notification tới Operator khi có ai xóa 1 file
....

## Best Practices for S3
- Chọn region của S3 cùng region với application (EC2, ECS) để tối ưu performance
- Sử dụng bucket policy cho những data quan trọng. Cấp quyền vừa đủ cho user/role, hạn chế cấp S3FullAccess
- Bật versioning để bảo vệ data tránh bị mất, xóa nhầm
- Mã hóa data nhạy cảm (client side or server side)
- Enforce TLS để yêu cầu sd HTTPS khi truyền nhận file (chống hack)
- Sử dụng VPC endpoint để tăng tốc truy cập từ application
- Khi host static web, nên kết hợp với CloudFront để tối ưu chi phí và tăng trải nghiệm người dùng

