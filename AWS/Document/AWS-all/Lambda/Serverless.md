## Cloud models
- Trên cloud có 4 mô hình phát triển:
    + OnPremises
    + IaaS(Infrastructure as a Services)
    + PaaS(Platform as a Services)
    + CaaS(Container as a Services)
    + FaaS(Function as a Services)

## IaaS - Infrastructure as a Services
- Đây là mô hình phổ biến nhất khi sử dụng cloud. AWS cloud sẽ public những API để client tương tác với VM, Storage... để user có thể tự quản lý infra trên cloud.
> VD: AWS Cloud exposes những API liên quan tới EC2, cho phép user administrator EC2 bằng web console hoặc AWS CLI hoặc SDK

## PaaS - Platform as a Services
- Đây là mô hình phát triển mà cloud sẽ cung cấp cho ta một Platform Framework để phát triển ứng dụng nhanh hơn
```
VD:
- Với IaaS: Khi triển khai 1 ứng dụng web trên cloud, đầu tiên phải tạo EC2 -> config security group -> Deploy application to EC2
- Với PaaS: AWS support AWS Elastic Beanstalk là 1 platform cho phép dễ dàng triển khai một ứng dụng web một cách nhanh chóng bằng web console
```
## Container as a Services
- Đây là mô hình triển khai Application trên container và có 1 số tool để quản lý những container này
VD: AWS EKS

## Function as a Services
- Đây là mô hình cấp nhỏ nhất, cloud cho phép phát triển ứng dụng chỉ dựa trên các Function.
- User không cần quan tâm tới infra. User chỉ cần quản lý những function và những function này có thể tự động auto scale mà không cần phải config gì và đây là thành phần chính trong serverless

## Serverless
- Đơn giản thì serverless là mô hình phát triển ứng dụng trên cloud mà cho phép ta xây dựng và chạy applications của chúng ta một cách dễ dàng mà không cần quan tâm tới hạ tầng

## Lợi ích của mô hình serverless
- Giảm thiểu chi phí của việc quản lí và vận hành server
- Automation scale and high-availability: FaaS sẽ tự động scale(horizontal scale) theo traffic
- Trả phí theo từng function được trigger
- Support nhiều ngôn ngữ khác nhau

## Điểm yếu của mô hình serverless
- Khó debug
- Cold Starts: Mất một khoảng thời gian nếu function được trigger lần đầu tiên hoặc function đó ít khi đưuọc request tới thì nó chạy lại khá tốn thời gian
- Khó tổ chức source code
- Khó thiết kế môi trường dev local
- Chỉ phù hợp cho các ứng dụng với traffic nhỏ
- Chỉ xử lý cho các workload mà chạy tối đa 15 phút

## Serverless Cloud providers
- Amazon web service: AWS Lambda
- Google Cloud: Google Cloud Functions
- Azure: Microsoft Azure Functions
## AWS Lambda
- AWS lambda là một service của AWS cho phép ta chạy và quản lý function. 
- User sẽ viết code dưới local và deploy lên AWS Lambda để chạy.
- Ngoài ra AWS Lambda còn được kết hợp với 1 số service để xây dựng mô hình serverless:
    + S3 Bucket: Thường được dùng lưu trữ hình ảnh
    + API Gateway: Thường được sử dụng xây dựng Restfull API
    + DynamoDB cho database
    + Cognito dùng để Authentication
    + SQS dùng cho queue
    + SNS dùng cho notification

- AWS Lambda được thiết kế cho event-driven architecture. Code của chúng ta sẽ được trigger dựa theo 1 event nào đó
>VD: Client request -> API. Các process trigger là độc lập với nhau và chúng ta chỉ cần trả tiền cho từng function được trigger và chạy. 


## Design REST API theo mô hình serverless
```
Client -> route 53 -> CloudFront, S3 bucket -> API GateWay -> Lambda function -> DynamoDb
```
- Trong đó:
    + Route 53: Service được dùng ddeerr route DNS tới CloudFront
    + CloudFront: Content Delivery Network Service dùng để cache static Content. CloudFront sẽ cache nội dung từ S3(Nơi lưu trữ Single Page Application, có thể là React - Angular - Vue)
    + Khi client tải nội dung từ Web Single Page Application thì trong ứng dụng sẽ gọi tới HTTP API tới API Gateway
    + API GateWay: Service dùng để xây dưng REST API và dẫn request tới Lambda
    + Lambda: Sẽ trigger từ API gateway -> DynamoDB -> xử lý request và response cho client



