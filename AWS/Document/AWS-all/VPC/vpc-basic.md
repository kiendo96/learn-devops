### What is VPC
- Viết tắt của Virtual Private Cloud
- Là 1 service cho phép người dùng tạo một mạng ảo (virtual network) và control toàn bộ network in/out của mạng đó
- VPC tương đối giống với network ở datacenter truyền thống tuy nhiên các khái niệm của AWs đã được đơn giản hóa giúp người dùng dễ tiếp cận


### Thành phần cơ bản
- VPC: Một mạng ảo được tạo ra ở cấp độ region
- Subnet: Một dải IP được định nghĩa nằm trong VPC. Mỗi subnet phải được quyết định Availability Zone tại thời điểm tạo ra
- IP Address: Ipv4 hoặc Ipv6 được cấp phát. Có 2 loại là public IP và Private IP
- Routing: Xác định traffic sẽ được điều hướng đi đâu trong mạng
- Elastic IP: IP được cấp phát riêng, có thể access từ internet (public), không bị thu hồi khi instance start -> stop
- Security Group: Đóng vai trò như một firewall ở cấp độ instance, định nghĩa traffic được đi vào/ đi ra. 
- Network Access Controll List (ACL): Được apply ở cấp độ subnet, tương tự như security group nhưng có rule Deny và các rule được đánh độ ưu tiên. Mặc định khi tạo VPC sẽ có 1 ACL được apply cho toàn bộ subnet trong VPC(Mở all traffic khoogn chặn gì cả)
- VPC Flow Log: capture các thông tin di chuyển của traffic trong network
- VPN Connection: Kết nối VPC trên AWS với hệ thống dưới On-premise
- Elastic Network Interface: Đóng vai trò như 1 card mạng ảo
- Internet Gateway: Kết nối VPC với internet, là cổng vào từ internet tới các thành phần VPC
- NAT Gateway: Dịch vụ NAT của AWS cho phép các thành phần bên trong kết nối tới internet nhưng không cho phép bên ngoài kết nối tới 
- VPC Endpoint: Kênh kết nối private giúp kết nối tới các services khác của AWS mà không thông qua internet
- Peering connection: Kênh kết nối giữa 2 VPC
- Transit Gateway: Đóng vai trò như 1 hub đứng giữa các VPCs, VPN connection, Direct Connect

### Internet Gateway
- Là cửa ngõ để truy cập các thành phần trong VPC
- Nếu VPC không được gắn internet Gateway thì không thể kết nối SSH tới instance kể cả instance đó có được gắn public IP
- Mặc định default-vpc do AWS tạo sẵn đã có gắn Internet Gateway

### NAT Gateway
- Giúp cho các instance trong Private Subnet có thể đi ra internet mà không cần tới public IP
- Giúp tăng cường bảo mật cho các resource cần private(App, DB)

### Network Access Control List (NACL)
- Control network in/out đối với subnet được associate
- Mỗi rule sẽ có các thông số:
    + Priority
    + Allow/Deny
    + Protocol
    + Port range
    + Source IP / Destination IP
- Default ACL sẽ allow all
- Sử dụng quá nhiều rule của ACL sẽ làm giảm performance
- Rule của ACL là stateless (Inbound, outbound phải tường minh. Không thể tự allow outbout như SG statefull)


### Security Group
- Elastic network interface(ENI): là một iterface cho phép instance giao tiếp với resource trên internet (kiểu giống thằng firewalld của os)
- 1 ENI được gắn với 1 hoặc nhiều SG.
- SG có thể gắn với 1 hoặc nhiều ENI
- SG thường được dùng để gom nhóm các resource có chung network setting(in/out, protocal, port)
- Khi thiết kế cần quan tâm tới tính tái sử dụng, dễ dàng quản lí
- Source của một Security Group có thể là CIDR hoặc id của một Security Group khác
- Rule của Security Group là statefull và không có Deny
**Statefull có nghĩa là nếu inbound cho phép traffic đi vào thì khi request tới sẽ nhận được response mà không cần explicit allow Outbound. Khác với Network ACL


### Điểm khác nhau của SG và NACL
- SG được gắn vào ENI còn NACL được gắn vào Subnet
- SG là statefull còn NACL là stateless
- SG có thể phân quyền cho các instance có thể giao tiếp với nhau hay không
- NACL phân quyền cho luồng traffic ra vào trong subnet chứ không phân quyền cho các instance được
- 1 Subnet chỉ có 1 NACL, 1 NACL có thể gắn được vào nhiều subnet

### Route Table
- Định tuyến traffic trong subnet hoặc gateway sẽ được điều hướng đi đâu
- Route table sẽ quyết định 1 subnet sẽ là private hay public
- Subnet được gọi là public khi có route đi tới Internet Gateway và ngược lại
- Một subnet chỉ có thể asociate 1 route table
- Default VPC do AWs tạo sẵn sẽ có 1 main route table asociate với toàn bộ subnet
    *Public: Subnet phải có route tới internet gateway
    *Private: Không có route tới internet gateway

### VPC Endpoint
- Giúp các resource trong VPC có thể kết nối tới các dịch vụ khác của AWS thông qua private connection
- Công dụng: secure, tăng tốc
- Có 2 loại endpoint là Gateway Endpoint (S3, DynamoDB) và Interface Endpoint (SQS, CloudWatch,..)
- Endpoint có thể được cấu hình Security Group để hạn chế truy cập

### Định nghĩa 1 VPC
- VPC được định nghĩa bằng 1 dải CIDR
- AWS cho recommend chọn 1 trong 3 dải CIDR sau(theo tiêu chuẩn RFC-1981):
    + 192.168.0.0 - 192.168.255.255
    + 10.0.0.0 - 10.255.255.255
    + 172.16.0.0 - 172.31.255.255
- Việc định nghĩa CIDR của IP cần tuân thủ một số tiêu chí sau:
    + Cover được số lượng IP private cần cấp phát trong tương lai
    + Tránh overlap các hệ thống có sẵn (kể cả on-premise) nếu không sẽ khoogn thể Peering

### Phân chia subnet
- Subnet được coi như 1 thành phần con của VPC
- Một VPC có thể chưa nhiều subnet khoogn overlap nhau
- Khi tạo subnet phải cọn Availability Zone
- Chọn CIDR cho subnet cần lưu ý:
    + Số lượng IP cho các resource cần cấp phát(EC2, Container, Lambda)
        VD: tạo 1 subnet 10.0.1.0/24 sẽ chứa được 256 IP trừ đi 5 reserve ip của IP -> 251 khả dụng
    + Số lượng subnet dự tính sẽ tạo trong tương lai
    + Đặt số sao cho dễ quản lí

### Pricing of VPC
- VPC là 1 dịch vụ miễn phí tuy nhiên user phải trả phí cho các resource liên quan
    + NAT Gateway: Tính tiền theo giờ ~$45/month/Gateway
    + VPC Endpoint: Tính tiền theo giờ và lưu lượng traffic
    + VPN Connection: Tính tiền theo giờ
    + Elastic IP: tính tiền theo giờ x số IP
    + Traffic: data đi ra ngoài interrnet
    + etc

### VPC advanced section
- VPC peering:
    + Là hình thức đơn giản nhất để kết nôi 2 VPC trên AWS. 2 VPC có thể cùng account hoặc khác account
    + Để thiết lập, một phía sẽ phải đưa ra peering request (requester) và bên còn lại sẽ accept request (Accepter)
    + Sau khi đã thiết lập quan hệ peering, cần cấu hình lại Route Table(Thêm route đi ra peering connection) và setting Security Group thích hợp để resource ở 2 VPC có thể connect lẫn nhau thông qua private IP(Không đi ra internet)
```
Noted:
+ VPC peering không có tính chất bắc cầu.
    VD: VPC-A peer VPC-B, VPC-B peer VPC-C không có nghĩa là VPC-A cũng peer với VPC-C
+ Hai VPC muốn peering được với nhau phải có dải IP CIDR không overlap
```


- Transit Gateway:
    + Đóng vai trò như 1 hub trung chuyển giữa On-Premise và AWS Cloud hoặc giữa nhiều VPC trên Cloud
    + Thường sử dụng kết hợp với Site-to-Site VPN hoặc Direct Connect
- Customer Gateway:
    + Là thiết bị vật lí của của customer và được sử dụng để làm kết nối site-to-site VPN, tunnel
    + Nôm na thì nó là router vật lí tại đầu khách hàng. Được sử dụng để làm 1 đường private giữa AWS với on-premise

- Site to Site VPN:
    + Là hình thức kết nối network Onpremise với network trên AWS Cloud
    + Customer gateway: Thiết bị vật lý hoặc virtual appliance ở phía On-Premise có nhiệm vụ điều hướng traffic
    + Thông tin được truyền giữa On-Premise và AWS Cloud được mã hóa
    + Bandwidth khoảng ~4Gbps
- Direct Connect:
    + Hình thức kết nôi từ On-Premise lên AWS Cloud thông qua một kênh connect low latency, high speed
    + Connection được duy trì thông qua một đường truyền chuyên dụng không qua public internet
    + Thông tin truyền đi giữa On-Premise và AWS cloud không được mã hóa by default
    + Bandwidth dao động từ 50Mbps-100Gbps
    + Khó setup hơn so với VPN, cần làm việc với nhà cung cấp direct connection

- Flow log:
    + Được sử dụng để lưu lại traffic của instance
    + Được đẩy lên CloudWatch