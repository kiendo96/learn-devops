# Jenkins Architecture - Task 3

![Overview](./images/banner_2.png)

## Task #3

Trong task này, bạn được yêu cầu:

- Build một một nodejs webapp đơn giản
- Cấu hình Freestyle Project để job chạy trên Jenkins Slaves

## 1. Cài đặt NodeJS plugin và npm

### 1.1.  Cài đặt NodeJS plugin  

- Vào mục **Manage Jenkins** => **Manage Plugins** => Chọn Tab **Available** và tìm **NodeJS** plugin.  
- Chọn **Install without Restart** và cài đặt.  

![Find NodeJS](./images/find_node_js_plugin.png)
  
### 1.2.  Cấu hình NodeJS plugin

- Vào mục **Manage Jenkins** => **Global Tool Configuration** => Tại phần **NodeJS** chọn **Add NodeJS** và chọn phiên bản **nodejs 12.0.0**  

![Add NodeJS](./images/config_nodejs_plugin.png)

## 2. Tạo Jenkins job  

- Chọn **New Item** và chọn **Freestyle project** đặt tên cho project và click **OK**  

![Create Freestyle Job](./images/new_simple_app.png)  

- Trong phần **General**, tích chọn **Restrict where this project can be run**, nhập vào label của Jenkins Slave

![Source Course Config](./images/specific_linux_slave_node.png)  

- Trong phần **Source Code Management** chọn tới link github của sample project. Ví dụ: `https://github.com/HoangPhu98/nodejs-demo`

![Source Course Config](./images/config_public_git.png)  

- Trong phần **Build Environment** chọn **Provide Node & npm bin/ folder to PATH** chọn NodeJS Installation cài đặt ở bước **#1.2**  

![Build Config](./images/select_build_env.png)

- Trong phần **Build** chọn **Add build step** => chọn **Execute Shell**.  Trong phần nội dung của Shell điền command build `npm install`  

![Execute Shell](./images/set_up_build_command.png)  

## 3. Build job  

Click **Build  Now** và kiểm tra kết quả của quá trình build.

- Trong trạng thái của `job`, xác nhận node thực hiện Job Build

![Build Job Status](./images/simple_app_output.png)

- Kết quả log của Job Build

![Build Job Log](./images/simple_app_output_2.png)
**Task #2 Completed**
