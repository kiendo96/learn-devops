# Một số web hữu ích:
- Document (https://docs.aws.amazon.com/cloudformation/)
- AwsLabs (https://github.com/awslabs/aws-cloudformation-templates)
# Giới thiệu
- Đầu tiên hãy xem qua lời mở đầu từ AWS.
>Speed up cloud provisioning with infrastructure as code ~ Dịch: Tăng tốc cung cấp Cloud với infrastructure as code.

- CloudFormation (CFn) là 1 AWS Service giúp chúng ta có thể tạo ra các cloud resource chỉ bằng definition files.

# Tình huống:
- Khi cần 1 architecture phức tạp cho project
- Khi cần tái tạo lại môi trường như nhau cho các dev, hoặc cần custom 1 phần giữa môi trường dev/prod
- Backup, lưu trữ lại 1 kiến trúc system của mình để sau này cần dùng đến.
- Release 1 architecture cho khách hàng, gửi 1 bundle để khách dễ dàng dựng trên AWS của mình
# So sánh để hiểu về ưu điểm của Cloudfomation:
- Nếu không có IaC: Ta tạo AWS resources bằng UI console, bằng CLI, hoặc dùng SDK (java, go,…) viết code tạo AWS resources.
    + Dùng UI: Có thể mắc phải Human Error, muốn trình bày cho khách/sếp mình đã tạo những gì thì phải quay video/chụp ảnh thao tác. Khi cần tạo lại môi trường y hệt cho khách hàng khác ta phải thao tác lại từ đầu. Ngoài ra việc quản lý resource sau khi tạo (muốn update/xóa) cũng sẽ phải thao tác các bước ngược lại. (tạo A-B-C thì khi xóa phải xóa C-B-A)
    + Dùng CLI: Viết các command line (Bash file) để tạo ra các resource. Mặc dù có thể sử dụng lại nhưng việc viết code bash rất khó khăn, có thể có bug tạo ra resource không đúng và gây thiệt hại lớn về tiền (do không biết để xóa). Ngoài ra khi xóa ta phải dùng các command khác, sửa sẽ 1 command khác. (x3 effort)
    + SDK: Giống CLI, chỉ được hơn điểm dễ đọc. Tuy nhiên việc cài đặt ngôn ngữ sẽ mất 1 ít thời gian.
- Nếu có CloudFormation: Tạo các files định nghĩa (gọi là Cloudformation Template) -> AWS Cloudformation sẽ đọc template và tạo resource như đã code sẵn. Khi tạo/sửa/xóa cũng chỉ cần 1 command. Tuy nhiên vẫn có một số nhược điểm sẽ nói sau
- Nếu dùng IaC khác: Có nhiều ưu/nhược điểm khác nhau, nhưng bài viết này tập trung vào Cloudformation
# Tính năng
- Viết file định nghĩa (Cfn template) -> Resources được tạo ra như mong muốn
- Sửa/Xóa bằng cách update lại file cfn template.
- State của resource được quản lý bởi AWS Cloudformation (có UI)
- Không phát sinh chi phí khi sử dụng (Vẫn tính phí cho resource được tạo ra) Lưu ý: có phát sinh khi dùng Type của 3rd party
- Hạn chế lỗi không kiểm soát (nếu lỗi AWS sẽ tự động xóa/rollback về trạng thái cũ, ko xảy ra tình trạng tạo nhầm Resource)
# Một số ví dụ:
- Normal Khi các step xảy ra suôn sẻ
    + Tạo Cfn template -> Deploy template -> Chờ và kiểm tra AWS Resource được tạo thành công
    + Cfn và AWS resource đang hoạt động -> Sửa Cfn template -> deploy lại -> Xem AWS resource đã được update thành công
    + Xóa Cfn template -> Kiểm tra AWS resource đã bị xóa
- Abnormal Khi có lỗi phát sinh (có thể là lỗi của AWS, có thể là lỗi của người dùng)
    + Tạo Cfn template (sai format) -> Deploy template -> AWS Cloudfomation báo lỗi và không tạo resource
    + Tạo Cfn template (tạo 1 resource ko đc phép - Ví dụ: 6 cái vpc) -> Deploy template -> AWS Cloudfomation báo lỗi và không tạo resource
    + Tạo Cfn template đúng -> Deploy và chờ Resource được tạo ra -> Update template lỗi -> Deploy -> AWS Cloudfomation báo lỗi và rollback trạng thái về ban đầu
    + Tạo Cfn template đúng -> Deploy và chờ Resource được tạo ra -> Xóa template nhưng không được phép (VD: Xóa ec2 nhưng chưa gỡ CNI) -> AWS Cloudfomation báo lỗi và không xóa bất kì resource nào
# Các tool tương tự
- Infrastructure as Code là 1 khái niệm, và có nhiều tool giúp làm được điều này. Có thể kể đến `Hashicorp Terraform, Pulumi, AWS CDK, Azure Resource Manger (chỉ dùng cho azure), Kubernetes manifest (chỉ dùng cho Kubernetes)`


# Concept
### Cloudformation:
>Là tên gọi 1 service IaaS mà AWS cung cấp. Cloudfomation đi kèm với các concept sau:

### Cfn Template
- Là 1 file yml hoặc json có chức năng đưa lên Cloudformation để tạo resource.
- File này tuân theo cách viết, các keyword mà aws đưa ra.

### Stack
- Khi 1 file yml/json được deploy thành công trên AWS, nó sẽ tạo 1 stack.
- Stack này có thể nhìn thấy trong Console AWS
- Là state của các resouce sau khi deploy

### Change sets
- Khi ta edit (hoặc override) 1 stack đang có sẵn trên Cloudfomation, thì ta có thể tạo ra Change sets để kiểm tra sự thay đổi trc khi quyết định deploy

### Drift detection
- Khi 1 stack được deploy, màn hình Console CFn sẽ hiện thị state chứa các resource đã đc định nghĩa sẵn trong stack. Khi các resource bị sửa đổi bởi tác nhân khác (manual, script, sdk) thì thông tin hiện trong stack sẽ không đúng nữa. Drift detection là chức năng giúp ta tìm được các resource trong stack đã bị sửa đổi

### Stack sets
- Là 1 chức năng giúp ta có thể cùng lúc deploy 1 stack lên nhiều account AWS (hoặc nhiều region) để tiện cho việc quản lý tập trung và update stack dễ hơn
- Referece: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/what-is-cfnstacksets.html

# AWSTemplateFormatVersion
>Hiện tại “2010-09-09”

# Description
>Thông tin ghi chú cho CFn, không ảnh hưởng tới resource

# Resources
### Parameters
>Là 1 giá trị truyền vào cho stack (như là 1 variable được truyền vào khi khởi tạo stack)

### Metadata
- Giúp sắp xếp vị trí parameter, hoặc ghi chú thêm cho từng parameter
- Đối với EC2, metadata giúp thêm Metadata vào EC2 khi tạo, Cloudfomation helper function sẽ có thể sử dụng metadata này (helper function sẽ nói sau)

### Mappings
- Mapping data dạng key-value
- Ví dụ EC2 AMI có id khác nhau với region khác nhau, ta thiết kế CFn để nhận parameter là region rồi dùng Mappings để tìm ra AMI id

### Conditions/Condition
- Conditions dùng để định nghĩa 1 điều kiện (trả về true/false)
- Condition dùng trong 1 resource, khi condition true thì mới tạo
- Dùng trong việc khi cần tạo resource có điều kiện (Vd: 1. chỉ tạo Security Group open all port cho môi trường dev, 2. chỉ tạo cloudfront cho môi trường prod)

### Outputs
- Hiện 1 giá trị ra ngoài CFn, để ta có thể thấy trên Console CFn, nếu dùng nested stack thì các stack cha có thể đọc được outputs của stack con

### Transform
- Tính năng nâng cao
- Khi có keyword transform trong Template, CFn sẽ gửi toàn bộ template cho 1 hàm lambda, hàm lambda sẽ tự xử lý template này và gửi về 1 output khác để deploy.
- Hiện tại có AWS Serverless application model (SAM) dùng SAM để thêm role tự động cho hàm lambda. Ngoài ra thực tế ít ai có thể custom được
