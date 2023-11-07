# Giới thiệu
- Bài lab hướng dẫn sử dụng Route53 để tạo weighted DNS record cho trang web nằm trên 2 site khác nhau
```
Note:
- Để nhanh chóng có kết quả, bài lab thực hiện tạo Route53 weighted record với TTL = 10s, cài đặt này sẽ làm lượng truy vấn DNS tăng cao, học viên nên xóa record sau khi thực hành để tránh phát sinh chi phí DNS query
- Học viên có thể thực hành tương tự với Geolocation policy
```

## Mục tiêu bài học
- Học viên hiểu và có khả năng thực nghiệm tạo Route53 Weighted Policy
## Chuẩn bị
- Trước khi thự hiện bài Lab, học viên cần lưu ý:
    + Chuẩn bị account AWS đã được active
    + Cấp phép sử dụng các dịch vụ liên quan đến Route53 (không nên sử dụng root user)
    + Đã có domain được quản lý trên Route53 public hosted zone

### Các bước thực hành

1. Bước 1: Tạo 2 EC2 instance đại diện cho 2 site: Trên giao diện EC2 instance, tiến hành tạo 2 instance nằm trong Default Subnet:
- Script user data:
```
#!/bin/bash
echo '<h1>Route53 Weighted Policy - Site 1</h1>' > index.html
echo 'Host name:<b> ' $HOSTNAME  '</b><br>' >> index.html
echo 'Instance id:<b> ' `wget -q -O - http://169.254.169.254/latest/meta-data/instance-id` '</b><br>' >> index.html
echo  'Avalibility Zone: <b>' `wget -q -O - http://169.254.169.254/latest/meta-data/placement/availability-zone` '</b><br>' >> index.html
python3 -m http.server 80
```
- Sau khi instance được tạo thành công và ở trạng thái running, truy cập vào trang web dựa trên địa chỉ IP public của instance
- Thực hiện tương tự và tạo instance thứ 2 đại diện cho Site 2 với Name Site-02 và user data:
```
#!/bin/bash
echo '<h1>Route53 Weighted Policy - Site 2</h1>' > index.html
echo 'Host name:<b> ' $HOSTNAME  '</b><br>' >> index.html
echo 'Instance id:<b> ' `wget -q -O - http://169.254.169.254/latest/meta-data/instance-id` '</b><br>' >> index.html
echo  'Avalibility Zone: <b>' `wget -q -O - http://169.254.169.254/latest/meta-data/placement/availability-zone` '</b><br>' >> index.html
python3 -m http.server 80
```
- Sau khi instance được tạo thành công và ở trạng thái running, truy cập vào trang web dựa trên địa chỉ IP public của instance
- Nếu trang web đã hiển thị như hình dưới đây, tức instance đã được cài đặt thành công

2. Bước 2: Tạo Route53 weighted record
- Trên giao diện AWS Console, truy cập dịch vụ AWS Route 53
- Tại Route53 dashboard, truy cập vào Hosted zone với domain bằng cách click trực tiếp vào tên của domain
- Chọn Create Record để tạo bản ghi DNS
- Nhập các thông tin như hình dưới đây, trong đó:
    + Record name: subdomain muốn tạo
    + Record type: A
    + Value: địa chỉ IP của instance Site-01
    + TTL: đặt ở giá trị 10 second để có thể thực hành nhanh chóng hơn
    + Routing policy: weighted
    + Weight: 50 (trong bài lab này, chúng ta sẽ thử nghiệm với giá trị 50/50 cho 2 Site)
    + RecordId: Site-01 (1 giá trị tùy chính theo ý của học viên, tuy nhiên các RecordId cần phải khác nhau giữa các bản ghi weighted policy)

- Sau khi nhập các thông tin trên, chọn Add another Record để tạo thêm record thứ hai. Ở record này, Value sẽ được gắn địa chỉ IP public của instance Site-01, và Record ID cũng được đặt khác với Record 1
- Kéo xuống cuối trang và chọn Create Record

3. Bước 3: thử nghiệm bản ghi weighted
- Trên web browser, thực hiện truy cập vào trang web với DNS đã được tạo. Chúng ta sẽ thấy rằng trang web được trả về đều cho cả Site-01 và Site-02
- Để nhìn rõ hơn kết quả truy vấn DNS được trả về, học viên có thể truy cập trang web https://dnschecker.org/ và nhập truy vấn DNS tới địa chỉ record và search, các kết quả về địa chỉ IP của Site-01 và Site-02 sẽ được trả về khá đồng đều:

### Tài liệu tham khảo
https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-weighted