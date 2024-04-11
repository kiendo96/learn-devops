# Jenkins Installation

## Task #1  

Trong task này, bạn được cài đặt Jenkins Server trên Docker, bên trong Jenkins Server này có cài đặt Docker client.

## Prequisites  

| Yêu cầu |  Version|  
|--|--|  
| OS | Ubuntu 18.04 |  
| Tài khoản github.com | N/A |  
| Docker| latest |  
  
## 1. Cài đặt Jenkins Server

### 1.1.  Fork Github Jenkins Course

> Các hướng dẫn và source code được lưu ở [đường dẫn này](https://github.com/HoangPhu98/jenkins-course). Mọi người Fork về Tài khoản Github cá nhân để tiện thực hành

![Fork Repo](./images/fork_repo.png)

- Sau khi **Fork** về repo cá nhân, Clone repo về máy tính

```sh
# Clone thư mục về Workspace
git clone https://github.com/${your_repo}/jenkins-course.git
```
  
### 1.2.  Cài đặt Jenkins Server

```sh
# Chuyển tới thư mục cài đặt Jenkins
cd jenkins-course/1_jenkins-installation/jenkins-docker

# Cài đặt Jenkins Server
sudo bash ./install_jenkins_server.sh
```

- Kiểm tra xem Jenkins Server đã chạy thành công hay chưa.

```sh
docker ps | grep jenkins-server
```

- Kiểm tra nếu Jenkins Server đã chạy thành công

![Visit Jenkins](./images/docker_ps_result.png)

### 1.3. Truy cập vào Jenkins

- Truy cập vào Jenkins sử dụng `http://localhost:8080` trong trường hợp sử dụng máy cá nhân hoặc `http://publicIP:8080`  trong trường hợp sử dụng Public Cloud Server

![Visit Jenkins](./images/visitJenkins.JPG)

- Lấy `password` của user admin và điền vào để hoàn thành đăng nhập

```sh
# Lấy password của user admin
cat /var/jenkins_home/secrets/initialAdminPassword
```

- Chọn cài đặt các Plugin mặc định

![Default Plugin](./images/defaultPlugins.JPG)

- Cài đặt user mới thay vì sử dụng User admin

![Create New User](./images/new_admin_user.png)

- Sau khi hoàn thành các bước trên bạn đã hoàn thành việc cài đặt Jenkins Server => **DONE**

![Setup Completed](./images/setup_completed.png)

## 2. Expose Jenkins Server ra internet sử dụng ngrok

> - Phần này dành cho các bạn chạy trên máy tính cá nhân, các bạn sử dụng Server Public Cloud thì bỏ qua.
> - Việc truy cập vào Jenkins Server phục vụ cho các phần Hands-on tiếp theo

- **ngrok** là công cụ cho phép bạn truy cập một dịch vụ trên máy tính cá nhân từ bên ngoài Internet

> Chú ý: **ngrok** chỉ nên sử dụng cho mục đích demo, không nên sử dụng trong mục dích chạy các dịch vụ thực tế trên Production

### 2.1. Đăng ký và cài đặt ngrok

- Đăng ký tại đây [https://dashboard.ngrok.com/](https://dashboard.ngrok.com/)

- Sau khi đăng ký xong Download ngrok và cài đặt theo hướng dẫn

```sh
# Download ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip

# Unzip và set path
unzip ngrok-stable-linux-amd64.zip
sudo mv ngrok /usr/local/bin

# Kiểm tra lại ngrok cài đặt thành công hay chưa
ngrok --version
```

- Sau khi cài đặt xong **ngrok** lấy **Authtoken** để hoàn thành cài đặt

![Ngrok Authtoken](./images/ngrokAuthToken.JPG)

- Cài đặt Authtoken

```sh
ngrok authtoken your_token
```

### 2.2. Expose Jenkins Server qua ngrok

- Setup đường kết nối forward tới cổng của Jenkins Server

```sh
ngrok http 8080
```

![Ngrok Authtoken](./images/ngrok_expose.png)

- Sau khi hoàn thành bạn có thể truy cập được Jenkins Server từ bên ngoài Internet

![Internet Access Jenkins Server](./images/ngrok_jenkins_done.png)

## Task #2

Trong task này, bạn sẽ được yêu cầu cấu hình và build một `Freestyle project`.

Tại màn hình Dashboard của Jenkins, ấn nút `New Item` trên menu

![New Item](./images/push_new_item.png)

Chọn `Freestyle project` và nhập tên cho Build Job. Nhấn nút OK để chuyển sang màn hình cấu hình cho Build Job.

![Fill Build Job Info](./images/name_and_select_freestyle_project.png)

Tại màn hình cấu hình Build Job, đưa mành hình xuống mục `Build` -> ấn `Add build step` -> chọn `Excute shell` -> nhập lệnh `echo "Hello World"` vào phần command -> ấn nút `Save`.

![Config Build Job](./images/add_command.png)

Tạo Job Build thành công, màn hình chuyển hướng về màn hình của Job Build -> ấn nút `Build Now` để thực hiện chạy Job Build.

![Build Trend](./images/build_now.png)

Xem tiến trình và kết quả tại phần `Build History`

![Build Trend](./images/build_trend.png)

Ấn vào một job để xem chi tiết, tại mục `Console Output`, bạn sẽ thấy kết quả của command trong phần cấu hình
![Build Job Created](./images/freestyle_job_done.png)
