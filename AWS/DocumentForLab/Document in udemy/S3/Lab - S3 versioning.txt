//Lab - Versioning
1. Yêu cầu chuẩn bị một file text có nội dung bất kì
2. Bật tính năng versioning của Bucket lên
3. Upload file lên S3
4. Chỉnh sửa nội dung, upload file với cùng tên. Confirm xem có một version mới được tạo ra
5. Tiến hành xóa file. Kiểm tra versioning với Delete Flag
6. Phục hồi file đã bị xóa bằng cách xóa Delete flag
7. Tắt versioning
8. Chỉnh sửa nội dung, upload file với cùng tên. Confirm xem file có bị ghi đè? Các version trước khi tắt versioning có còn không?

=> Tạo 1 file text name: "test.xt"
    => thêm nội dung bất kì
        => Enable tính năng version của S3 "Bật khi khởi tạo bucket hoặc enable trong Properties"
            => Chỉnh sửa nội dung file đã up lên S3 trước đó
                => Upload lại file với nội dung mới lên cùng bucket S3
                    => Vào check version của file sẽ thấy có 2 version được khởi tạo
                        => Try delete file => Nó sẽ tạo ra 1 DELETE MARKER để ẩn file đi
                            => Try delete marker => File sẽ được khôi phục trở lại
=> Access S3 properties => Edit "Bucket versioning" => Choose "Suspend" để tắt tính năng versioning
    => Các version trước của file vẫn còn tồn tại nhưng current version không còn tồn tại Version ID