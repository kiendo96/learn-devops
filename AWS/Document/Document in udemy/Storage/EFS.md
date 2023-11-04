//////Amazon EFS - Elatic File System ///////
- Managed NFS (network file system) that can be mounted on many EC2
- EFS works with EC2 instance in multi-AZ
- Highly available, scalable, expensive (x3 gp2 EBS), pay per use
- Use cases: content management, web serving, data sharing, wordpress
- Uses NFSv4.1 protocol
- Uses security group to control access to EFS
- Compatible with Linux based AMI (not Windows)
- Encryption at rest using KMS
- POSIX file system (~Linux) that has a standard file API
- File system scales automatically, pay-per-use, no capacity planning!

//EFS-Performance & Storage Classes
- EFS Scale:
    + 1000s of concurrent NFS client, 10 GB+ /s throughput
    + Grow to Petabyte-scale network file system, automatically

- Performance Mode (set at EFS creation time)
    + General Purpose (default): latency-sensitive use case (Web server, CMS ...)
    + Max I/O - higher latency, throughput, highly parallel (big data, media processing)
- Throughput Mode:
    + Bursting - 1 TB = 50MiB/s + burst of up to 100MiB/s
    + Provisioned - set your throughput regardless of storage size, ex: 1 Gb/s for 1 TB storage
    + Elastic - automatically scales throughput up or down based on your workloads
        ++ Up to 3 GB/s for reads and 1 GB/s for write
        ++ Used for unpredictable workloads

*EFS - StorageClass
- Storage Tiers (lifecycle management feature - move file after N days)
    + Standard: for frequently accessed files
    + Infrequent acess (EFS-IA): cost to retrieve files, lower price to store. Enable EFS-IA with a lifecycle policy
- Avalability and durability:
    + Regional(Standard): Multi-AZ, great for prod
    + One Zone: One AZ, great for dev, backup enabled by default, compatible with IA (EFS One Zone-IA)
- Over 90% in cost savings

///Tham số khi tạo EFS
- Virtual private cloud (VPC): Cần chọn VPC mà EFS và EC2 instance cùng nằm chung thì chúng mới có thể kết nối đến nhau
- Regional: Các replica của EFS sẽ nằm ở các AZ khác trong cùng 1 region
- One Zone: Các replica của EFS chỉ nằm trong 1 AZ. Mức độ Availability và Durability sẽ kém hơn với Regional
- Enable automatic backups: Nếu chọn sẽ kích hoạt tự động backup. Sẽ mất thêm chi phí cho việc này
- Transition into IA: Sau N ngày nếu không có truy suất đến file thì chuyển nội dung EFS sang vùng lưu trữ Infrequent Access. N có thể là 7,  14, 30, 60, 90 days
- Transition out of IA: Nếu có truy xuất file EFS đang ở vùng lưu trữ Infrequent Access: hoặc là chuyển trở về vùng lữu trữ thường hoặc không làm gì cả.
- Performance Mode có 2 lựa chọn:
    + General Purpose: phù hợp cho nhiều nhu cầu sử dụng khác nhau.
    + Max I/O: tối ưu để có tổng thông lượng đọc/ghi cao nhất
- Throughput mode có 2 lựa chọn:
    + Bursting: scale tuỳ theo nhu cầu truy xuất thực tế
    + Provisioned: dự toán trước
- Enable encryption of data at rest: mã hoá nội dung EFS

//Networking
- Để EC2 kết nối được vào EFS cần đáp ứng 2 điều kiện
    + EFS và EC2 nằm cùng trong một VPC
    + EFS mở cổng 2049 (inbound rule) và EC2 đuợc kết nối đến cổng 2049 (outbound rule)
