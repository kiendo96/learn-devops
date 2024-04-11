# Jenkins Architecture - Task 1  

![Overview](./images/banner_1.JPG)

Trong task này, bạn được yêu cầu tạo 1 Jenkins Slave container, sau đó add Jenkins slave này vào Jenkins master sử dụng SSH protocol.  

## 1. Tạo Jenkins Slave container

### 1.2.  Sửa install script để run Jenkins Slave

- Tạo cặp keypair để cho **Jenkins Master** có thể kết nối được tới **Jenkins Slave** qua **SSH**

```/bin/bash
# Di chuyển tới thư mục của Hands-on
cd jenkins-course/2_jenkins-slave/scripts

# Sinh ssh keypair và lưu tại thư mực đang làm việc
# Nhập <path_to_repo>/2_jenkins-slave/scripts/id_rsa khi được yêu cầu 'Enter file in which to save the key'
ssh-keygen -t rsa

# Change mode private key
sudo chmod 400 id_rsa

# Chạy script để tạo cài đặt Jenkins Slave
sudo bash ./install_jenkins_slave.sh
```

### 1.3. Kiểm tra trạng thái của Jenkins Slave Container  

```/bin/bash
# Tại host cài đặt Jenkins Slave container
# Kiếm tra Container đã chạy thành công hay chưa
docker ps

# Kiểm tra kết nối ssh tới Jenkins Slave container
ssh -i id_rsa jenkins@localhost -p2222

# Thoát khỏi Jenkins Slave Ctrl + D
# Trong trường hợp connection bị denied thì xóa file known_hosts đi
rm ~/.ssh/known_hosts

# lấy IP của Node mà Jenkins Slave đang chạy trên đó
ifconfig
# Ví dụ kết quả thu được 172.34.167.174 với output của ifconfig
# eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
#        inet 172.24.167.174  netmask 255.255.240.0  broadcast 172.24.175.255
#        inet6 fe80::215:5dff:feac:9db5  prefixlen 64  scopeid 0x20<link>
```

```/bin/bash
# Tại host chạy Jenkins Master container
# Tạo thư mục .ssh trên
mkdir -p /var/jenkins_home/.ssh

# Add Jenkins Slave là trusted servers trên Jenkins Master, 
# trong ví dụ này, jenkins_slave_node_ip = 172.34.167.174
ssh-keyscan -p2222 <jenkins_slave_node_ip> > /var/jenkins_home/.ssh/known_hosts
```

## 2. Thêm Jenkins Slave node trên Jenkins Master

### 2.1. Cài đặt SSH Credential

- Vào **Manage Jenkins** => **Manage Credentials** => Click **(global)** => **Add Credentials** . Chọn **Kind** là **SSH Username vs Private Key**.
- Chọn Username là **jenkins**
- Điền ID: **ssh_slave_credentail**
- Phần Private Key copy nội dung của file **id_rsa** được gen ở bước **#1.1**
- Ấn nút **Create**

![Add SSH Credential](./images/slave_cred_setup.png)

### 2.2. Add Jenkins Slave Node

- Vào **Manage Jenkins** => **Manage Nodes and Cloud** => **New Node** => điền giá trị Node name **linux-slave-01** => ấn Create và tự động chuyển hướng tới cấu hình Slave

![Add SSH Credential](./images/new_node_slave.png)

- Điền thông tin theo của Slave Container

| Field | Giá trị  | Ý nghĩa|
|--|--|--|
| Name | linux-slave-01 | Tên của Node|
| Number of executors | 1 | Mỗi Executor sẽ chạy được 1 Job|
| Labels| linux-slave | Nhãn để lựa chọn Node build sau này|
| Launch method| Launch agents via SSH |Sử dụng SSH để kết nối tới Slave|
| Host| <jenkins_slave_node_ip> | IP của slave node để Master kết nối SSH tới|
| Credential | ssh_slave_credential | SSH private key và User đã tạo ở  phần 2.1 |
| Port | 2222 | SSH Port |
| JavaPath| /usr/local/openjdk-14/bin/java | Đường dẫn tới Java Binary |

![Detail Informaton](./images/new_node_slave_config_1.png)

![Detail Informaton](./images/new_node_slave_config_2.png)

- Save thông tin và kiểm tra trạng thái của Slave

![Add Node](./images/new_node_slave_done.png)
**Task #1 Completed**

## 3. Trouble Shooting

### Đồng bộ thời gian giữa các node

### Chạy Jenkins Master trên node vật lý & Jenkins Slave trên docker

```
Trên Node Master, switch tới user jenkins và tạo cặp khóa rsa
$ su - jenkins
$ ssh-keygen 
# enter -> enter theo các giá trị mặc định

Thoát khỏi jeknins user, trở lại user root 
Ctrl + D

# Tạo thư mục jenkins home cho slave
$ mkdir -p /var/jenkins_home_slave/.ssh

# Copy id_rsa.pub vào thư mục .ssh của jenkins_home của slave
# (Nếu server jenkins master không chạy cùng jenkins slave thì phải copy file từ node master sang slave)
$ cp /var/lib/jenkins/.ssh/id_rsa.pub /var/jenkins_home_slave/.ssh/authorized_keys

# Thay đổi permission và owner của các file và folder
$ chmod 700 /var/jenkins_home_slave/.ssh
$ chmod 600 /var/jenkins_home_slave/.ssh/authorized_keys
$ chown -R 1000:1000 /var/jenkins_home_slave

# Cài đặt Jenkins trên docker
docker run -p 2222:22 -v /var/jenkins_home_slave:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --restart always -d --name jenkins-slave hoangphu98/jenkins-slave:latest

# Trên node Master, Switch tới user jenkins và thực hiện test và thêm known_hosts
su - jenkins
ssh -i id_rsa jenkins@<slave_node_ip>  -p2222
ssh-keyscan -p2222 <slave_node_ip> > /var/lib/jenkins/.ssh/known_hosts
```

Tiếp tục làm  **2. Thêm Jenkins Slave node trên Jenkins Master**
