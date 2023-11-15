# Overview
- Work with multiple origins in CloudFront
- Trong bài lab này, chúng ta tạo 1 CloudFront distribution gồm có 2 cache behaviour
    + Behaviour 01: GET request gửi đến /img/* --> forward đến S3-bucket1 chứa ảnh
    + Behaviour 02: Các request còn lại gửi đến S3 static web (in S3-bucket2)

# Chuẩn bị
- S3 bucket 1: static web hosting trên S3 chứa 1 file index.html
- File index.html của static web có nội dung sau
```
    <!DOCTYPE html>
    <html>
    <body>

    <h1>test</h1>

    <img src="/img/cat_1.jpeg"/>
    <img src="/img/cat_2.jpeg"/>
    <img src="/img/cat_3.jpeg"/>

    </body>

    </html>
```

- S3 bucket 2: dùng để chứa ảnh, sẽ có 1 thư mục img, bên trong thư mục img là 3 ảnh cat_1.jpeg, cat_2.jpeg, cat_3.jpeg
- Bucket được cấu hình cho phép public read access (bỏ chọn Block Public Access, bucket policy cho phép GetObject và GetObjectVersion từ tất cả principal)

# Hướng dẫn chi tiết
- Step 01: Tạo CloudFront distribution trỏ đến origin là S3 static web. Có thể tham khảo bài lab trước
- Step 02: Truy cập CloudFront url để kiểm tra
- Step 03: Có thể thấy ảnh không load được.
    + Nguyên nhân là do trình duyệt gửi GET request đến /img/*.jpeg. `Request này được xử lý bởi default cache behaviour của distribution. Nếu không có cache behaviour nào matching với request path pattern` (/img/*.jpeg) thì request đó sẽ được forward đến S3 bucket đang được dùng để host static web (bucket 1). Tuy nhiên S3 bucket 1 này chỉ chứa file index.html, không có các object /img/*.jpeg, do đó không thể tìm thấy ảnh và trả về lỗi 404

- Step 04: Để sửa lỗi, chúng ta tạo thêm 1 cache behaviour xử lý các request gửi đến /img/*.jpeg. Các request này sẽ được cache behaviour forward đến S3 bucket 2. Muốn vậy, trước tiên ta tạo thêm 1 origin cho distribution
    + Ở tab Origins, chọn Create Origin

- Step 05: Ở mục origin domain, chọn bucket chứa ảnh, sau đó Create origin
- Step 06: Sau khi đã có thêm origin, chúng ta bắt đầu tạo thêm cache behaviour.
    + Ở tab Behaviour, chọn Create behaviour

- Step 07: Ta lần lượt cấu hình
    + Path pattern: /img/.jpeg
    + Origin: chọn S3 bucket chứa ảnh
    + Sau đó click Create behaviour
    + Mọi GET request gửi đến /img/.jpeg sẽ được forward đến bucket 2 (chứa ảnh). Các ảnh ở bucket 2 đã được để trong thư mục img/, do đó khi nhận được các request có pattern /img/*.jpeg thì bucket sẽ trả về ảnh ở đường dẫn tương ứng
- Step 08: Ở tab Behaviour lúc này đã có 2 cache behaviour với thứ tự ưu tiên matching khác nhau
    + Mọi request khi gửi đến CloudFront distribution sẽ được so sánh path pattern lần lượt với từng cache behaviour theo thứ tự thấp --> cao, ngay khi tìm được cache behaviour nào khớp thì sẽ được behaviour đó xử lý

- Step 09: Sau khi tạo xong cache behaviour, đợi một lúc để cho CloudFront distribution triển khai cache behaviour đến các edge location. Sau khi cột Last modified chuyển từ trạng thái Modifying sang hiển thị ngày tháng thì truy cập lại vào CloudFront url để kiểm tra