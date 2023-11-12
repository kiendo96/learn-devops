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

### Advantage (Ưu điểm)
- Usecase được dùng nhiều nhất là kết hợp vơi `Spot instance` để tiết kiệm chi phí đáng kể
- Tự động chạy async nhiều job cùng lúc trên nhiều máy, kết quả được quản lý tập trung trên AWS Batch
- Có thể tạo Job dependence, nghĩa là job này sẽ run khi job khác hoàn thành (thông thường việc timming 1 batch sau khi batch khác chạy hoàn thành sẽ rất khó, nhất là batch chạy across trên nhiều máy)
- Flex về config môi trường. AWS Batch dựa trên EC2 hoặc Fargate và AWS Batch cũng cho phép config các thông số như CPU, RAM, GPU, IAM role `tiện lợi vì quản lý các resource khác nhau trên cùng UI`
- Track log tập trung, track được status của job

### Compare
- AWS Lambda
- AWS ECS Task + Eventbridge
- Step function
- Apache airflow


# AWS Batch concept
### Job
- Job là Unit of Work của AWS Batch, nó là instance của Job definitions
- 1 lần chạy batch xem như tạo 1 job, job status cũng chính là status của batch app chạy như thế nào
- `aws batch submit-job --job-name abc-run --job-definition xyz-craw-web --job-queue def-queue`
- Job có thể chạy theo `simple jobs` hoặc `array jobs`. Array jobs là khi chạy job ta đặt nó phụ thuộc vào job khác để được chạy theo tuần tự
- `aws batch sumbit-job -depends-on 12345678-1234-1234-1234-123456789012 ...`
- Chi tiết hơn về `array job`: https://docs.aws.amazon.com/batch/latest/userguide/example_array_job.html

### Job definitions
- Khá giống với ECS Task definitions
- Khai báo những gì cần thiết để job chạy, có thể hiểu đây chính là app của mình, code xong hết và chờ run. Khi run thì sẽ tạo ra 1 instance đó là Job
- 1 số config có thể khai báo tại đây
    + IAM role cho Job (khi job chạy có cần access vào s3, dynamoDB, …)
    + vCPU and Memory
    + Environoment variables
    + Container properties (nếu run bằng container)
    + Mount point container
    + `aws batch register-job-definition --job-definition-name abc --container-properties ...`

### Job queue
- AWS Batch sẽ chạy Job trên 1 lượng resource nhất định và có giới hạn (đc định nghĩa trong Compute environments)
- Vì lý do trên nên queue sẽ giúp các Jobs có thể chờ đến khi đc run chính thức
- Các info cho job đã complete sẽ tồn tại 24h trên queue
- `aws batch create-job-queue --job-queue-name abc-queue --priority 500 --compute-environment-order ...`

### Compute environments
- Job queue sẽ được gắn với 1 hoặc nhiều Compute Environments (gọi tắt CE)
- Compute Environments chính là các định nghĩa tạo Infras cho AWS Batch, có thể là EC2/ECS fargate
- Managed/Unmanaged CE
    + Managed thì aws sẽ quản lý EC2 cũng như tự cài đặt autoscale, AWS cũng quản lý luôn việc sử dụng spot instance
    + Unmanage thì phải tự tạo instance và đưa vào AWS Batch (Yêu cầu instance phải có ECS agent)
    + AWS Batch sẽ tự tạo ECS cluster để tự quản lý EC2/ECS

### Scheduler
- Là 1 tác vụ (app chạy ngầm) của AWS Batch, luôn đánh giá 1 Job khi nào có thể start (đo chỉ số requirement của job, resource hiện tại của CE, có scale hay ko, …)

### Job state
- `Submitted`: Job đã được đưa lên queue nhưng chưa dc xử lý
- `Pending`: Job đã được xử lý nhưng đang bị phụ thuộc vào job khác (pending tới khi job kia hoàn thành)
- `Runnable`: Job được aws batch đánh giá sắp chạy, đang chờ CE cung cấp resource
- `Starting`: đã bắt đầu đưa job lên CE, chờ log và agent uppdate thành running
- `Running`: Job đang chạy
- `Succeded`: Job đã finish với exit code = 0
- `Fail`: Job finish với exit code != 0, hoặc bị cancel / terminate