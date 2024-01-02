### Provider
```
provider "aws" {
    region = "us-east-1"
}
```

### Resource
```
provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "hello" {
    ami = "ami-079db87dc4c10ac91"
    instance_type = "t2.micro"
    tags = {
        Name = "HelloWorld"
    }
}
```
- `resource` is a `block`
- `aws_instance` are `resource type`
- `hello` are name of block
- `arguments`: input of resource
- `attributes`: output of resource

```
Arguments[ami, instance_type, tags] -> aws_instance -> Attributes[ami, instance_type, tags, id, arn(computed attributes)]
```

### View terraform's properties on the website below:
>https://registry.terraform.io/

# Licycle
```
Create [Wordspace] -> Write [main.tf] -> terraform init -> terraform plan -> terraform apply -> terraform destroy
```

```
# terraform plan -out plan.out
# terraform show -json plan.out > plan.json
```
- Tất cả các resource type của tf đều implement một CRUD interface, trong CRUD interace này sẽ có các funtion hooks là CRUD và function này sẽ được thực thi nêu gặp điều kiện phù hợp
- Data type thì implement một Read interface chỉ có 1 function hook là read()

### Data block
- `data`: block này được dùng để call API tới infrastructure thông qua provider và query 1 thông tin resource nào đó
```
provider "aws" {
    region = "us-east-1"
}
data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    owners = ["099720109477"] #Canonical Ubuntu account id
}

resource "aws_instance" "hello" {
    ami = data.aws_ami.ubuntu.id    #call to data block and value is id of ami
    instance_type = "t2.micro"
    tags = {
        Name = "HelloWorld"
    }
}
```

- Flow:
```
Data arguments[most_recent, filter, owners] -> aws_ami(data source) -> Data attribute[id, most_recent, filter, owners, ami] 
    -> Resource arguments[ami, instance_type, tags] -> aws_instance(resource) -> Resource attributes[id, ami, instance_type, tags]
```

### Plan
- `terraform plan`: 
    + Sử dụng để kiểm tra resource nào sẽ được tạo ra
    + Nếu resource đã tồn tại thì plan giúp kiểm tra có những thay đổi gì trong file terraform
- Các step chính của plan:
    + Đọc file configuration và state file
    + Thực hiện tính toán để xác định action nào sẽ được thực thi CRUD hoặc không làm gì cả `No-op`
    + Output plan

>Option: -auto-approve sẽ tự động yes khi apply

### No-op
- When resource is existed and sau đó khi plan đọc qua file state và chúng ta apply mà không có thay đổi gì thì sẽ đi qua bước no-op

### Update resource
- Khi edit resource trong file tf và apply thì tf sẽ destroy resource cũ -> apply resource mới
- Trong tf resource sẽ có 2 loại thuộc tính (attribute) là `force new` và `normal update`
    + `Force new attribute`: resource sẽ được re-create
    + `Normal update attribute`: resource được update bình thường mà không cần xóa resource cũ

### Delete resource
- Ta xóa resource bằng câu lệnh: `terraform destroy`
- Trước khi destroy thì thực hiện plan để đọc state file để kiểm tra sau đó mới thực hiện destroy

### Resource drift
- Khi thay đổi config được deploy trước đó bằng tf, sau đó bị thay đổi bên ngoài terraform (cli, web console, sdk...)
- Khi chạy: `terrform plan` sẽ thấy output: `Note: Objects have changed outside of Terraform`

# Input Variable
- Structure:
```
variable "words" {
    ...
}
```
- In there:
    + variable is element
    + words is name
- File name default is `variable.tf` hoặc đặt tên gì cũng được
- Example: in file variable.tf
```
variable "instance_type" {
    type= string
    description = "Instance type of the EC2"
}
```
- `Attribute type` is required
    + Basic type: string, number, bool
    + Complex type: list(), set(), map(), object(), tuple()
- `Attribute description` is optional

- Example access variable
```
provider "aws" {
    region = "us-east-1"
}
data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    owners = ["099720109477"] #Canonical Ubuntu account id
}

resource "aws_instance" "hello" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type   #access variable
    tags = {
        Name = "HelloWorld"
    }
}
```

### Assign value for variable
- Create file: `terraform.tfvars` for test
```
instance_type = "t2.micro"
```
=> Khi apply thì mặc định đọc value này

- Create file: `production.tfvars` for production
```
instance_type = "t3.medium"
```
=> Khi apply: terraform apply -var-file="production.tfvars"

### Validating variables
- `validation`: giá trị này để kiểm tra biến instance_type chỉ được phép nằm trong mảng array cho phép
```
variable "instance_type" {
    type= string
    description = "Instance type of the EC2"
    validation {
        condition = contrains(["t2.micro", "t3.medium"], var.instance_type)
        error_mesage = "Value not allow"
    }
}
```
- Nếu khi apply value trong file `terraform.tfvars` khác "t2.micro" hoặc "t3.medium" => sẽ nhận về message "Value not allow"

### Output
- Structure:
```
output "ec2" {
    value = {
        public_ip = aws_instance.hello.public_ip
    }
}
```
- When run `terraform apply` in result will see output is ec2 = {"public_ip" = "`192.168.1.12`}

### Count parameter
- `Count` là một meta argument
- Là một thuộc tính trong terraform chứ không phải của resource type thuộc provider
```
provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "hello" {
  count         = 5 #create this resource 5 
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}

output "ec2" {
  value = {
    public_ip1 = aws_instance.hello[0].public_ip
    public_ip2 = aws_instance.hello[1].public_ip
    public_ip3 = aws_instance.hello[2].public_ip
    public_ip4 = aws_instance.hello[3].public_ip
    public_ip5 = aws_instance.hello[4].public_ip
  }
}
```
- Trong phần output chúng ta vẫn phải access vào giá trị này 5 lần. Để giải quyết vấn đề này chúng ta sẽ sử dụng for expressions

### For Expressions
- Structure:
```
for <value> in <list> : <return value>
```

- Edit main.tf
```
provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "hello" {
  count         = 5 #create this resource 5 
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}

output "ec2" {
  value = {
    public_ip = [ for v in aws_instance.hello : v.public_ip ]
  }
}
```

- Format function: Nối chuỗi output
```
...
output "ec2" {
  value = {
    public_ip = [ for i, v in aws_instance.hello : format("public_ip%d, i+1" => v.public_ip ]
  }
}
```

### Local values
- Giúp khai báo một giá trị local trong file terraform và có thể sử dụng lại được nhiều lần
- Structure
```
locals {...}
```
- Locals block được gán thẳng values cho nó
```
locals {
  one = 1
  two = 2
  name = "max"
  flag = true
}
```
- Access local value: `local.<KEY>`