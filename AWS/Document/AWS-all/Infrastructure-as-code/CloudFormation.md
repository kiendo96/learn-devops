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
- ếu có CloudFormation: Tạo các files định nghĩa (gọi là Cloudformation Template) -> AWS Cloudformation sẽ đọc template và tạo resource như đã code sẵn. Khi tạo/sửa/xóa cũng chỉ cần 1 command. Tuy nhiên vẫn có một số nhược điểm sẽ nói sau
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
