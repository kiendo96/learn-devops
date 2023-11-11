# AWS Batch
- Ứng dụng chính: Chạy batch
- Developer chỉ cần tạo ra thứ cần chạy (shell script, linux excutable file - binary file, Docker image), phần còn lại AWS Batch sẽ quản lý (Role, VPC, AutoScale...)
- Một số đặc điểm:
    + Fully Managed: No software to install or servers to manage. AWS Batch provisions, manages, and scales your infrastructure
    + Integrated with AWS: Natively integrated with the AWS platform, AWS Batch jobs can easily and securely interact with services such as Amazon S3, DynamoDB, and Rekognition
    + Cost-optimized Resource Provisioning: AWS Batch automatically provisions compute resources tailored to the needs of your jobs using Amazon EC2 and EC2 Spot
- Một số usecase:
>https://aws.amazon.com/blogs/compute/tag/batch/

>http://www.karimarttila.fi/aws/2017/11/09/aws-batch-and-docker-containers.html

>https://aws.amazon.com/blogs/compute/using-aws-parallelcluster-serverless-api-for-aws-batch/

```
- Nhìn vào các usecase có thể thấy AWS là 1 wrapper xung quanh EC2 hoặc ECS, full-managed cho việc chạy batch
- Nghĩa là app vẫn chạy trên EC2 và ECS fargate như bình thường nhưng ta có 1 tool phía ngoài quản lý hộ việc: Create EC2 instance, scale, UI...
```

# Advantage (Ưu điểm)
- Usecase được dùng nhiều nhất là kết hợp vơi `Spot instance` để tiết kiệm chi phí đáng kể
- Tự động chạy async nhiều job cùng lúc trên nhiều máy, kết quả được quản lý tập trung trên AWS Batch
- Có thể tạo Job dependence, nghĩa là job này sẽ run khi job khác hoàn thành (thông thường việc timming 1 batch sau khi batch khác chạy hoàn thành sẽ rất khó, nhất là batch chạy across trên nhiều máy)
- flex về config môi trường. AWS Batch dựa trên EC2 hoặc Fargate và AWS Batch cũng cho phép config các thông số như CPU, RAM, GPU, IAM role `tiện lợi vì quản lý các resource khác nhau trên cùng UI`
- Track log tập trung, track được status của job

# Compare