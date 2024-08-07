### What is Route53?
- DNS: Domain name system: Là 1 hệ thống quản lý các tên miền và ánh xạ chúng thành địa chỉ IP của máy chủ, cho phép các ứng dụng truy cập vào các dịch vụ trên internet bằng tên miền thay vì sử dụng địa chỉ IP
- AWS Route 53 là một dịch vụ quản lý tên miền và DNS (Domain Name System) được cung cấp bởi Amazon Web Services(AWS). DNS AWS Route 53 cho phép bạn đăng ký và quản lý tên miền, tạo và cấu hình các bản ghi DNS và điều hướng các yêu cầu từ tên miền đến các nguồn tài nguyên khác nhau trên AWS và bên ngoài. Điều này bao gồm điều hướng yêu cầu đến máy chủ Web, máy chủ email, CDN và các tài nguyên
- Route 53 cung cấp một loại tính năng như đám mây DNS, chống chịu tải, đám mây phân phối nội dung, bảo mật và theo dõi tình trạng tài nguyên. Nó cũng tích hợp tốt với các dịch vụ khác của AWS, cho phép bạn tự động cập nhập bản ghi DNS khi tạo hoặc xóa các nguồn tài nguyên tên AWS

### Tính năng Route53
- Route 53 cung cấp 3 tính năng chính:
  + Register Domain Name: Cho phép mua và quản lý tên miền, tự động gia hạn(optional). Cũng có thể đem một domain đã mua của bên thứ 3 và quản lý trên route 53
  + DNS Routing: Điều hướng internet traffic tới một resource nhất định
    VD: EC2 IP, Application LoadBalancer, Cloud Front, API Gateway, RDS...
  + Health checking: tự động gửi request đến các resource để check tình trạng hoạt động. Có thể kết hợp với Cloud Watch alarm để notify khi có resource unhealthy

### Route53 hosted zone
- Route53 hosted zone là một khái niệm trong AWS Route53. Một hosted zone đại diện cho một tên miền hoặc một tên miền con trong hệ thống DNS. Nó là nơi quản lý các bản ghi DNS(DNS Record) và cấu hình liên quan cho tên miền cụ thể
- Hosted zone public sẽ map với một tên miền cụ thể (Có thể mua bởi Route 53 hoặc bên thứ 3). Private hosted zone cũng map với tên miền tuy nhiên chỉ có tác dụng trong scope một VPC.
- Sau khi hosted zone, có thể thêm các bản ghi DNS vào nó như A Record, CNAME Record, MX record và nhiều loại bản ghi khác. Có thể cấu hình các bản ghi này để điều hướng yêu cầu tới các tài nguyên khác nhau, chẳng hạn như server web, server email hoặc dịch vụ khác trên internet
- Có thể tương tác với Hosted zone thông qua console hoặc AWS API từ đó cho phép update tự động các DNS record

### Các loại DNS record
- A Record (Address Record): Xác định một địa chỉ IPv4 cho tên miền. Nó ánh xạ một tên miền vào một địa chỉ IP v4
- AAAA Record(IPv6 Address Record): Tương tự như A Record, nhưng sử dụng để xác định một địa chỉ IPv6 cho tên miền
- CNAME Record(Canonical Name Record): Nó được sử dụng để tạo đường dẫn từ một tên miền thứ cấp(subdomain) đến một tên miền ở bất cứ đâu trên internet
- MX Record(Mail Exchange Record): Xác định các máy chủ chịu trách nhiệm nhận và xử lý thư điện tử cho một tên miền. Nó được sử dụng để định vụ máy chủ email.
- TXT Record(Text Record): Cho phép lưu trữ các dữ liệu văn bản tùy ý cho tên miền. Nó thường được sử dụng để xác thực tên miền và cung cấp thông tin khác nhau cho các dịch vụ khác.
- SRV Record(Service Record): Xác định vị trí và cấu hình dịch vụ cụ thể trên mạng. Nó được sử dụng chủ yếu trong việc xác định các máy chủ chịu trách nhiệm cho các dịch vụ như VoIP (Voice over IP) và IM (Instance Mesaging)
- NS Record(Name Server Record): Xác định máy chủ tên miền (Name server) chịu trách nhiệm quản lý các bản ghi DNS cho tên miền cụ thể. Nó cho phép bạn chỉ định máy chủ DNS mà bạn muốn sử dụng cho tên miền của mình
- PTR Record(Pointer Record): Sử dụng thực hiện ánh xạ địa chỉ IP thành tên miền. Nó được sử dụng chủ yếu trong việc xác định tên miền từ một địa chỉ IP cụ thể

### Routing Policy
- Khi tạo 1 DNS record, cần quyết định routing policy nào sẽ sử dụng cho record đó:
  + Simple routing policy: Sử dụng trong trường hợp trỏ DNS Record tới một resource riêng lẻ
    VD: CloudFront, WebServer run on Ec2
  + Failover routing policy: Sử dụng khi cấu hình một cặp resource hoạt động theo cơ chế active - passive failover. Thường sử dụng trong private hosted zone
  + Geolocation routing policy: Điều hướng traffic từ user tới các target dựa trên vị trí địa lý của user
  + Geoproximity routing policy: Sử dụng khi bạn muốn điều hướng traffic dựa trên vị trí của resource. Cũng có thể shift traffic từ resource location này sang resource ở location khác.
  + Latency routing policy: Sử dụng khi có nhiều resource trên multi regions và muốn điều hướng traffic tới region có latency tốt nhất
  + IP-based routing policy: Điều hướng traffic dựa trên location của user và dựa trên IP address mà traffic bắt nguồn
  + Multivalue answer routing policy: Sử dụng khi muốn query up-to 8 record healthy được lựa chọn ngẫu nhiên
  + Weight routing policy: Phân chia tỉ lệ điều hướng tới target theo tỷ lệ nhất định theo mong muốn

### Route53 health check
- Route 53 định kì thực hiện các call tới endpoint bạn muốn thực hiện health check. Nêu response failed hoặc không trả về response, Route 53 sẽ raise alarm tới CloudWatch Alarm kết hợp với SNS đề notify tới người nhận
- Các thông số có thể setting health check bao gồm:
  + IP/Domain name cần check
  + Protocol(TCP, HTTP, HTTPS)
  + Interval
  + Failure threshold. VD: 3 lần không có response thì tính là fail
  + Notification (Optional) kết hợp với CloudWatch Alarm và SNS

### Route 53 Pricing
- Về cơ bản Route 53 tính tiền dựa trên các yêu tố
  + Giá của tên miền (Khác nhau tùy đuôi VD: .com, .net, .click) sẽ có phí thường niên khác nhau
  + Hosted Zone: $0.5/month
  + Query: Ví dụ - $0.4/1M query standard, $0.6/1M query latency
  + Health check: $0.5/health check/month
  + Log: Phụ thuộc vào giá của CloudWatch
