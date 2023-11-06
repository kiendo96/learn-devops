# Overview
- Trong bài lab này, chúng ta thực hành S3 encrypt object trên giao diện AWS Console.
# Content
- Kiểu encrypt chúng ta sử dụng sẽ là: SSE-KMS
- Để thực hiện SSE-KMS, trước tiên chúng ta cần tạo key trên KMS theo các bước sau:
```
- Step 1: Login tài khoản AWS bằng IAM user với quyền Admin
- Step 2: Tìm và chọn service KMS
- Step 3: Trên giao diện KMS, chọn Customer managed key, sau đó chọn Create key
- Step 4: Chọn Symmetric Key, bấm Next
- Step 5: Đặt tên cho key. Hãy chọn một tên phù hợp với use case
- Step 6: Chọn IAM user/role có quyền quản lý key. Hãy chọn IAM user mà mình đang đăng nhập (Admin)
- Step 7: Chọn IAM user/role có quyền sử dụng key. Hãy chọn IAM user mà mình đang đăng nhập (Admin)
- Step 8: Chọn Finish
    + Sau khi đã có key trên KMS, chúng ta quay lại service S3 để tiến hành SSE-KMS:
- Step 9: Mở dịch vụ S3 và tạo một bucket. Lưu ý tên bucket phải globally unique
- Step 10: Vào bucket vừa tạo và chọn Upload. Chọn 1 file bất kỳ, mở mục Properties
- Step 11: Kéo xuống phần Server-side encryption settings, chọn option Specify an encryption key --> chọn option AWS Key Management Service key (SSE-KMS) --> chọn option Choose from your AWS KMS keys. Trong dropdown list, chọn KMS key chúng ta vừa tạo ở bước 8
- Step 12: Chọn Upload. Như vậy chúng ta đã có 1 object được encrypt theo kiểu SSE-KMS.
```