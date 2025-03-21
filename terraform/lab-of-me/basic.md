# Working with terraform

### Files of Terraform
- `*.tf`: Chứa các khai báo tài nguyên cơ sở hạ tầng dưới dạng code
- `.terraform \ providers \ registry.terraform.io \ hashicorp \ aws \ 5.42.0 \ windows_386 \ terraform-provider-aws_v5.44.0_x5.exe`: file plugin để terraform tương tác với Provider và quản lý tài nguyên theo cấu hình Terraform
- `terraform.tfstate`: lưu trữ trạng thái hiện tại của cơ sở hạ tầng
- `terraform.tfstate.backup`: file backup của tfstate sử dụng restore khi cần thiết
- `.terraform.lock.hcl`: sử dụng để khóa version của Provider và module đang được sử dụng
- `terraform.tfstate.lock.info`: khóa state, đảm bảo tại 1 thời điểm thực hiện thay đổi state chỉ có 1 tiến trình hoặc 1 người được sửa đổi

### Terraform command
- `terraform init`: khởi tạo môi trường bằng cách cài đặt các plugin và module cần thiết cho provider
- `terraform fmt`: định dạng lại cấu hình theo chuẩn
- `terraform validate`: kiểm tra tính hợp lệ của cấu hình
- `terraform plan`: xem trước những tác động, thay đổi trước khi áp dụng vào provider
- `terraform destroy`: xóa các tài nguyên đã tạo

# Hashicorp configuration language
- HCL là ngôn ngữ được hashicorp phát triển để ghi các tệp cấu hình, được sử dụng để xác định và định cấu hình tài nguyên cơ sở hạ tầng. HCL được thiết kế để người dùng dễ đọc và dễ hiểu, tập trung vào sự đơn giản
- HCL được sử dụng bởi một số công cụ hashicorp, bao gồm: terraform, vault, nomad, packer
- Ngôn ngữ cấu hình của terraform dựa trên hcl

### 1. Comments
- Có 3 cú pháp:
  + `#`: comment 1 dòng
  + `//`: thay thế cho #
  + `/* code */`: comment có thể trải dài trên nhiều dòng

### 2. Block
- Khối code chứa nội dung xác định
```
block_type "block_label" {
  parrameter1 = value1
  parrameter2 = value2
}
```

### 3. Attributes:
- Cặp key-value trong blocks

```
key1 = value
key2 = value
```

### 4. Data types:
- `string`: chuỗi ""
- `number`: số
- `bool`: true or false
- `list`: ["value1", "value2", "value3"]
- `map`: một nhóm giá trị được xác định bằng key-value. vd: my_map = {name = "kiendt", age = 30}
- `set`: tương tự như list nhưng các giá trị trong set là duy nhất

### 5. Conditionals:
- Sử dụng toán tử ba ngôi thay cho if else
- Syntax: `condition ? true : false`
- VD: instance_type = var.env == "dev"?"t2.micro":"t3.micro"

### 6. Function
- String: `format, join, spli`
- Numeric: `min, max, pow`
- Data and Time: `formatdate, timestamp`
- Type Conversion: `tobool, tomap, tolist`

### 7. Resource Dependencies
- Thiết lập mối quan hệ phụ thuộc giữa các resource
```
resource "aws_ket_pair" "ssh-key" {
  key_name = "sshkey"
  public_key = file("sshkey.pub")
}

resource "aws_instance" "ssh-inst" {
  ami = "ami-23121541312313"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh-key.key_name
  vpc_security_group_ids = ["sg-123fsdfda342"]
  tags = {
    Name = "ssh-instance"
    Project = "ssh"
  }
}
```

# Meta-Arguments

## Argument
- Xác định bằng cặp key-value: `image_id = "abc123"`
- Mỗi dạng tài nguyên có một tập đối số khác nhau
```
resource "aws_ket_pair" "ssh-key" {
  key_name = "sshkey"
  public_key = file("sshkey.pub")
}
```
- Sử dụng vói các `block` và `module` để kiểm soát hành vi của terraform hoặc ảnh hưởng đến quá trình cung cấp cơ sở hạ tầng
- Cung cấp các tùy chọn cấu hình bổ sung ngoài các đối số dành riêng cho tài nguyên thông thường
- Meta-argument thường được sử dụng:
  + count
  + for_each
  + provider
  + depends_on
  + lifecycle

### 1.Count
- Được gán với giá trị là số nguyên: `count = 5`
- Tạo ra dạng tài nguyên giống nhau
- Loại bỏ trùng lặp cấu hình
- count.index bắt đầu từ 0
```
resource "aws_instance" "server" {
  count = 4
  ami = "ami-avasd3342s"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}
```

### 2.For_each
- Cho phép tạo nhiều tài nguyên giống nhau dựa trên `map` hoặc `set` của string
- Có 2 thuộc tính của for_each
  + `each.key`: giá trị là key của 1 cặp key-value
  + `each.value`: giá trị là value của 1 cặp key-value
```
locals {
  ami_ids = {
    "linux": "ami-avc23121"
    "ubuntu": "ami-sdadssc2321"
  }
}

resource "aws_instance" "server" {
  for_each = local.ami_ids
  ami = each.value
  instance_type = "t2.micro"
  tags = {
    Name = "Server ${each.key}"
  }
}
```

### 3.Provider
- Cho phép chỉ định hoặc ghi đè region trên 1 cloud hoặc chỉ 1 cloud khác so với cloud đang sử dụng
- Ex1: Multiple provider
```
provider "aws" {
  region = "us-east-1a"
}

provider "aws" {
  alias = "us-east-1b"
  region = "us-east-1b"
}

resource "aws_instance" "server" {
  count = 1
  ami = "ami-4324sddfds"
  instance_type = "t2.micro"

  tags = {
    Name = "server 01"
  }
}
```

- Ex2: Multiple cloud
```
#defined aws provider configuration
provider "aws" {
  region = "us-west-2"
}

#defined GCP provider configuration
provider "google" {
  project = "my-project"
  region = "us-central1"
}

# create aws s3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket"
  acl = "private"
}

#create a GCP storage bucket
resource "google_storage_bucket" "example_bucket" {
  name = "example-bucket"
  location = "us-central1"
}
```

### 4. Depends_on
- Chỉ định sự phụ thuộc giữa các tài nguyên. Nó đảm bảo răng một tài nguyên được tạo hoặc cập nhập trước tài nguyên khác
```
resource "aws_instance" "web_server" {
  ami = "ami-adasd3432dsadad"
  instance_type = "t2.micro"
  count = 2
}

resource "aws_security_group" "web_security_group" {
  name = "web_security_group"
  description = "web server security group"

  # The web_security_group resource depends on the web_server resource
  depends_on = [ aws_instance.web_server ]
}
```

### 5. Lifecycle
- Xác định các quy tắc vòng đời để quản lý các cập nhật, thay thế và xóa tài nguyên
- Lifecycle là 1 dạng block được chỉ định trong block tài nguyên để cung cấp hướng dẫn cụ thể cho tài nguyên đó
- Các đối số có sẵn trong Lifecycle:
  + `create_before_destroy`: Tạo tài nguyên thay thế trước khi xóa
  + `prevent_destroy`: ngăn Terraform destroy tài nguyên
  + `ignore_changes`: chỉ định các thuộc tính mà Terraform nên bỏ qua khi xác định có cập nhật tài nguyên
  + `replace_triggered_by`: chỉ định danh sách các thuộc tính mà khi thay đổi sẽ kích hoạt việc thay thế tài nguyên

# Data source
- Lấy thông tin của 1 dạng tài nguyên bên ngoài sự quản lý của terraform hoặc đã tồn tại
- Được miêu tả bằng block `data`
- Mỗi 1 `resource` có 1 `data resource` riêng để tham chiếu
- Sử dụng cú pháp `data.<type>.<name>.<attribute>` để lấy dữ liệu mong muốn
```
data "aws_instance" "name" {
  filter {
    name = "tag:Name"
    values = ["VM-04"]
  }
}

output "name" {
  value = data.aws_instance.name.ami
}
```

# Variables and Output
- Ngôn ngữ terraform bao gồm một số loại `Block` nhập liệu giá trị hoặc xuất các giá trị được đặt tên
- Bao gồm:
  + `Local values`
  + `Input variables`
  + `Output variables`

### 1. Locals value
- Được miêu tả bằng block `locals`
- Nó là nhóm các cặp `key-value` được sử dụng trong cấu hình
- Hữu ích để tránh lặp lại cùng một giá trị hoặc biểu thức nhiều lần trong một cấu hình
- Sử dụng cú pháp `local.<Name>` để tham chiếu
```
locals {
  ami = "ami-asda3432rfds"
  type = "t2.micro"
  tags = {
    Name = "ec2"
    Department = "IT"
    Owner = "Kiendt"
  }
}

resource "aws_instance" "myvm" {
  ami = local.ami
  instance_type = local.type
  tags = local.tags
}
```
### 3. Input variable
- Được miêu tả bằng block `variable`
- Sử dụng để truyền các giá trị nhất định từ bên ngoài vào cấu hình
- Input variable là đóng vai trò như đầu vào cho các module
- Syntax: `var.<name>`
- Các đối số:
  + Type: Kiểu giá trị của biến
  + Description: Mô tả cho block
  + Default: giá trị mặc định

```
variable "ami" {
  type = string
  description = "AMI ID for the EC2 instance"
  default = "ami-dfdso342dsf"
}

resource "aws_instance" "myvm" {
  ami = var.ami
  instance_type = var.type
  tags = var.tags
}
```
### 4. Output value
- Được miêu tả bằng block `output`
- Output sử dụng để lấy thông tin từ các resource sau khi đã được triển khai
- Giá trị trong block output sẽ được in ra sau khi chạy `terraform apply` hoặc có thể sử dụng command `terraform out`
- Các đối số trong block output
  + `value`: giá trị đầu vào chúng ta muốn in ra
  + `description(optional)`: Mô tả cho block
  + `sensetive(optional)`: Tính nhạy cảm của giá trị đầu ra `True - False`

```
output "instance_ami" {
  value = aws_instance.VM-03.ami
  description = "AWS EC2 instance ID"
  sensitive = true
}
```
