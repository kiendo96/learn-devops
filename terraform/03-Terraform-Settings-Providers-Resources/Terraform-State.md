# Terraform State
- Terraform must store state about your managed infrastructure and configuration //Terraform phải được lưu trạng thái infrastructure và cấu hình
- This state is used by Terraform to map real world resources to your configuration (.tf files), keep track of metadata, and to improve performance for large infrastructures //Trạng thái này được Terraform sử dụng để ánh xạ các tài nguyên trong thế giới thực tới cấu hình của bạn (tệp .tf), theo dõi siêu dữ liệu và cải thiện hiệu suất cho cơ sở hạ tầng lớn
- This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment.
- The primary purpose of Terraform state is to store bindings between objects in a remote system and resource instances declared in your configuration.
- When Terraform creates a remote object in response to a change of configuration, it will record the identity of that remote object against a particular resource instance, and then potentially update or delete that object in response to future configuration changes  //Khi terraform khởi tạo a remote object để phản hồi lại thay đổi của cấu hình, nó sẽ record lại đối tượng đó dựa trên 1 resource instance cụ thể , sau đó có khả năng cập nhật hoặc xóa đối tượng đó để phản hồi những thay đổi cấu hình trong tương lai
## Resource Behavior
- Terraform Resource
  + `Create Resource`: Create resources that exist in the configuration but are `not associated` with a real infrastructure object in the state. //create resource đã tồn tại trong cấu hình nhưng không liên kết với real infrastructure object nào trong file state
  + `Destroy Resource`: Destroy resources that `exist in the state` but no longer exist in the configuration //Destroy resource tồn tại trong file state nhưng không tồn tại trong cấu hình
  + `Update in-place Resources`: Update `in-place resources` whose arguments have changed
  + `Destroy and re-create`: Destroy and re-create resources whose arguments have changed but which cannot be updated in-place due to remote API limitations