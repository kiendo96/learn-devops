# Overview
- Show how to use CloudFront with a basic configuration
- Publicly distribute a video file globally

# Hướng dẫn chi tiết
- Step 1: Prepare your file
>E.g., Video “Cách học AWS cho người mới bắt đầu hiệu quả nhất - phần 1 | Learn AWS The Hard Way | Techmaster” in Youtube

- Step 2: Store your object (file) into a S3 bucket
- Step 3: Grant public read permissions to the objects in your S3 bucket
    + Clear “Block all public access” configuration at bucket level
    + Grant Read to Everyone (public access) at Access Control List (ACL) of the file.
- Step 4: Create a CloudFront distribution
    + Under Origin Settings, for Origin Domain Name, choose the Amazon S3 bucket that you created earlier.
    + Ở mục Origin domain, copy paste đường link của S3 static web, sau đó scroll xuống, chọn Create distribution
    + Đợi cho đến khi status của distribution mới tạo chuyển thành Enabled và cột Last modified chuyển từ Deploying sang hiển thị ngày tháng, lúc đó distribution đã được deploy đến các edge location
- Step 5: Access your content through CloudFront
>Click vào ID của distribution để xem chi tiết, truy cập vào domain name