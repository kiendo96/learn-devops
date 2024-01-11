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

# Variables block

As you being to write Terraform templates with a focus on reusability and DRY development (don't repeat yourself), you'll quickly being to realize that variables are going to simplify and increase usability for your Terraform configuration. Input variables allow aspects of a module or configuration to be customized without altering the module's own source code. This allows modules to be shared between different configurations.

Input variables (commonly referenced as just 'variables') are often declared in a separate file called `variables.tf`, although this is not required. Most people will consolidate variable declaration in this file for organization and simplification of management. Each variable used in a Terraform configuration must be declared before it can be used. Variables are declared in a variable block - one block for each variable. The variable block contains the variable name, most importantly, and then often includes additional information such as the type, a description, a default value, and other options.

The variable block follows the following pattern:

### Template

```hcl
variable “<VARIABLE_NAME>” {
  # Block body
  type = <VARIABLE_TYPE>
  description = <DESCRIPTION>
  default = <EXPRESSION>
  sensitive = <BOOLEAN>
  validation = <RULES>
}
```
### Example

```hcl
variable "aws_region" {
  type        = string
  description = "region used to deploy workloads"
  default     = "us-east-1"
  validation {
    condition     = can(regex("^us-", var.aws_region))
    error_message = "The aws_region value must be a valid region in the
    USA, starting with \"us-\"."
  }
}
```

The value of a Terraform variable can be set multiple ways, including setting a default value, interactively passing a value when executing a terraform plan and apply, using an environment variable, or setting the value in a `.tfvars` file. Each of these different options follows a strict order of precedence that Terraform uses to set the value of a variable.

# Local block
Locals blocks (often referred to as locals) là các value được defined trong Terraform được sử dụng để giảm các tham chiếu lặp đi lặp lại đối với expression or value. Locals rất giống với traditional input variables và có thể được tham chiếu trong suốt cấu hình Terraform. Locals are often used to give a name to the result of an expression to simplify your code and make it easier to read.

Locals are not set directly by the user/machine executing the Terraform configuration, and the values don't change between or during the Terraform workflow (`init`, `plan`, `apply`).

Locals are defined in a `locals` block (plural) and include named local variables with their defined values. Each locals block can contain one or more local variables. Locals are then referenced in your configuration using interpolation using `local.<name>` (note `local` and not `locals`). The syntax of a locals block is as follows:

### Template

```hcl
locals {
  # Block body
  local_variable_name = <EXPRESSION OR VALUE>
  local_variable_name = <EXPRESSION OR VALUE>
}
```

### Example

```hcl
locals {
  time = timestamp()
  application = "api_server"
  server_name = "${var.account}-${local.application}"
}
```

# Data Block
Terraform sử dụng `data block` để load hoặc query data from APIs hay một số tác vụ khác. Có thể sử dụng dữ liệu này để làm cho cấu hình dự án của bạn linh hoạt hơn và để kết nối các không gian làm việc quản lý các phần khác nhau trong cơ sở hạ tầng của bạn. Cũng có thể sử dụng `data source` để connect và share data giữa các workspaces in Terraform Cloud and Terraform Enterprise

Data Block bao gồm các components:
- Data Block: `resource` là top-level keywork like `for` and `while` trong các ngôn ngữ khác
- Data Type: The next value is the type of the resource. Resource type luôn có prefixed theo nhà cung cấp của chúng. Có thể có nhiều loại resource giống nhau trong cấu hình terraform
- Data Local Name: The resource type and name together form the resource identifier, or ID. In this lab, one of the resource IDs is aws_instance.web. The resource ID must be unique for a given configuration, even if multiple files are used.
- Data Arguments - Most of the arguments within the body of a resource block are specific to the selected resource type. The resource type's documentation lists which arguments are available and how their values should be formatted.

Example:
A data block requests that Terraform read from a given data source ("aws_ami") and export the result under the given local name ("example"). The name is used to refer to this resource from elsewhere in the same Terraform module.

### Template

```hcl
data “<DATA TYPE>” “<DATA LOCAL NAME>”   {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```

# Terraform Block
Terraform dựa trên plugins gọi là "providers" để tương tác với remote systems và expand functionality. Terraform cấu hình phải được khai báo providers nào có thể  cài đặt và sử dụng chúng. This is performed within a Terraform configuration block

Template:
```hcl
terraform {
  # Block body
  <ARGUMENT> = <VALUE>
}
```

Example:
```hcl
 terraform {
   required_version = ">= 1.0.0"
 }

# Module Block
A module được sử dụng để combine resources thường xuyên sử dụng vào trong một container(thùng chứa). Các module riêng lẻ có thể được sử dụng để xây dựng một giải pháp tổng thể cần thiết để triển khai các ứng dụng. Mục tiêu là phát triển các module có thể được tái sử dụng theo nhiều cách khác nhau, do đó giảm số lượng mã cần phát triển.
Modules are called by a `parent` or `root` module, and any modules called by the `parent` module are known as `child` modules.
Modules can be sourced from a number of different locations, including remote, such as the Terraform module registry, or locally within a folder. While not required, local modules are commonly saved in a folder named `modules`, and each module is named for its respective function inside that folder. An example of this can be found in the diagram below:

```
aws-architecture-root
  |
  |----> modules
  |         |----> vpc_module
  |         |         |----> main.tf
  |         |         |----> variables.tf
  |         |         |----> outputs.tf
  |         |----> subnet_module
  |
  v
main.tf
variables.tf
outputs.tf
```