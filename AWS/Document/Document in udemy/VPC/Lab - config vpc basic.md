# Thiết kế VPC basic
- Thiết kế 1 VPC theo yêu cầu
    + VPC CIDR: 10.0.0.0/16
    + Có 2 loại subnet Public, Private. Mỗi subnet chứa ít nhất 1000 IPs
    + Mỗi loại subnet nằm ở ít nhất 2 AZ
    + Có 1 internet gateway, cấu hình route table tới Internet Gateway
    + Có 1 NAT Gateway, cấu hình route table tới NAT Gateway
- Thiết kế security group cho 4 nhóm đối tượng:
    + Application LoadBalancer (ALB): expose port HTTPS 443
    + App server cho phép port 80 từ ALB, 22 từ Bastion server
    + Database Server sử dụng MYSQL port 3306. Elasticsearch port 9200
    + Bastion Server: SSH port 22 từ IP company
    + Thiết kế VPC Endpoint cho S3 Services

# Tạo VPC và các thành phần
1. VPC
```
Create VPC => VPC only => IPV4 CIDR = 10.0.0.0/16
```

2. Subnets
```
-> Create subnet -> Choose VPC created in previous -> create new subnet "public" => Choose "Availability Zone" -> Enter subnet CIDR "10.0.0.0/22"
=> Add new subnet "public"   -> Choose "Availability Zone" -> Enter subnet CIDR "10.0.4.0/22"
=> Add new subnet "private"   -> Choose "Availability Zone" -> Enter subnet CIDR "10.0.8.0/22"
=> Add new subnet "private"   -> Choose "Availability Zone" -> Enter subnet CIDR "10.0.12.0/22"
```

3. IGW(free)
```
Create internet Gateway -> action "Attach to VPC" -> choose "VPC in previous"
```

4. NAT GW
```
Create nat gateway -> choose "subnet public" -> Allocate Elastic IP
```

5. Route Table(Public and private)
```
*create route table public
-> create route table -> choose "VPC"
    => edit routes => add route to internet "0.0.0.0/0" attach to internet gateway
        => subnet associations => edit subnet associations => choose two subnet public
*create route table private
-> create route table -> choose "VPC"
    => edit routes => add route to internet "0.0.0.0/0" attach to nat gateway
```

6. VPC endpoint for S3, cấu hình route table private đi ra S3 Endpoint
```
Create endpoint -> Services "S3" => type Gateway => choose VPC => Route table "private route table"
```


7. Security Groups
```
=> Create new security group => name: "public-sg" => attach to "VPC in previous" => inbound rules "HTTPS"
    => Create new SG for "bastion" -> name: "public-bastion" => attach to "VPC in previous" => inbound rules "SSH"
        => Create new SG for "app-sg" -> name: "public-app-sg" => attach to "VPC in previous" => inbound rules "HTTP" => Source "public-sg" => inbound rules "SSH" => source "public bastion"
            => Create new SG for "database-sg" -> name: "public-database-sg" => attach to "VPC in previous" => open "TCP"port 9200 and "MYSQL Aurora" 3306 => source from app-sg => "MYSQL Aurora" 3306 => source from bastion-sg
```

# Test VPC:
1. create 1 new instance trong public subnet, gán bastion-sg, thử kết nối
2. Gán Elastic IP cho instance, thử kết nối qua Elastic IP
3. Tạo 1 instance trong private subnet, gán app-sg thử kết nối từ bastion
4. Ping từ private ra internet"
5. Thử gỡ bỏ route đi NAT từ private subnet, thử thao tác với S3 từ private instance để check xem S3 Endpoint có hoạt động không. "Nhớ gán role cho EC2 instance"
```
=> create a new instance => attach vpc in previous lab -> subnet "public" => choose security group for "bastion"
    => create a new Elastic IPs -> Allocate elastic ip address to bastion server
=> Create a new instance => attach vpc private subnet => attach app-sg  => try connect from bastion to app instance
```
