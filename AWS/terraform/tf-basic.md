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
