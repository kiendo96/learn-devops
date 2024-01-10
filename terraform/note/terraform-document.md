# Basic command
- `terraform -version`
- `terraform init`: Khởi tạo thư mục làm việc với terraform
- `terraform validate`: Valiation configuration
- `terraform plan`: Tạo ra 1 plan theo resource
- `terraform apply`: Apply plan
- `terraform destroy`: Xóa toàn bộ cấu hình

# HashiCorp Configuration Language
- Terraform is written in HCL (HashiCorp Configuration Language) and is designed to be both human and machine readable. HCL is built using code configuration blocks which typically follow the following syntax:
```
# Template
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
 # Block body
<IDENTIFIER> = <EXPRESSION> # Argument
}

# AWS EC2 Example
resource "aws_instance" "web_server" { # BLOCK
  ami = "ami-04d29b6f966df1537" # Argument
  instance_type = var.instance_type # Argument with value as expression (Variable value replaced 11 }
```

- Terraform code configuration block type:
  + `setting` block
  + `provider` block
  + `resource` block
  + `data` block
  + `input` variable block
  + `local` variable block
  + `output` values block
  + `modules` block

# Provider block
- Terraform `Provider` là plugin giúp người dùng tương tác với các nền tảng cloud thông qua API
- Các nền tảng `terraform provider` phổ biến: AWS, Google Cloud, Azure, Vmware, Kubernetes....
### Install the Terraform AWS Provider
- Để tương tác được với cloud thì terraform cần được cung cấp provider thông qua `required_providers` in `terraform` block
Example:
```hcl
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
```
- Run `terraform init` để cài đặt provider cho project
```shell
terraform init
```
- Review version và check provider đã install
```shell
terraform -version
terraform providers
```

# Resource Block
Terraform sử dụng resource block để manage infrastructure, như là: virtual networks, compute instances or higher-level components như là DNS records. `Resource Blocks` đại điện cho 1 hoặc nhiều infrastructure object bên trong terraform configuration. Hầu hết các providers đều có một số tài nguyên khác nhau ánh xạ tới các API thích hợp để quản lý loại cơ sở hạ tầng cụ thể đó.

```hcl
# Template
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>"   {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```

| Resource   | AWS Provider       | AWS Infrastructure |
| ---------- | ------------------ | ------------------ |
| Resource 1 | aws_instance       | EC2 Instance       |
| Resource 2 | aws_security_group | Security Group     |
| Resource 3 | aws_s3_bucket      | Amazon S3 bucket   |
| Resource 4 | aws_key_pair       | EC2 Key Pair       |

When working with a specific provider, like AWS, Azure, or GCP, the resources are defined in the provider documentation. Each resource is fully documented in regards to the valid and required arguments required for each individual resource. For example, the `aws_key_pair` resource has a "Required" argument of `public_key` but optional arguments like `key_name` and `tags`. You'll need to look at the provider documentation to understand what the supported resources are and how to define them in your Terraform configuration.

**Important** - Without `resource` blocks, Terraform is not going to create resources. All of the other block types, such as `variable`, `provider`, `terraform`, `output`, etc. are essentially supporting block types for the `resource` block.