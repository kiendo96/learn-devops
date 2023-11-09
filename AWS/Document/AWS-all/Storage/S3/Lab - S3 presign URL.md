# Lab - Presign URL(Sử dụng CLI)
1. Yêu cầu đã cài sẵn aws CLI để thiết lập profile tại máy local
2. Upload 1 file bất kì lên S3
3. Phát hành 1 Presign url cho object trên S3 bằng command
4. Sử dụng URL để download file trên trình duyệt
5. Đợi hết thời gian hiệu lực của url, thử lại => expired

# Noted
```
Connect CLI to S3 -> up thử 1 file -> use command: "aws s3 presign [S3Uri] --expires-in [time=second]" -> Copy URL to browser 
```

# Lab
- Create a presigned URL for an S3 object by console or AWS CLI

### Content
### 1. Create a pre-signed URL by console
- In the Objects list, select the object that you want to create a presigned URL for.
- On the Actions menu, choose Share with a presigned URL.
- Specify how long you want the presigned URL to be valid.
- Choose Create presigned URL.
### 2. Create a pre-signed URL by CLI
>aws s3 presign s3://DOC-EXAMPLE-BUCKET/test2.txt --expires-in 3600
- Copy URL vừa được tạo và paste vào trình duyệt ẩn danh để xem kết quả