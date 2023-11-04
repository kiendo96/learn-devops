//Lab - Presign URL(Sử dụng CLI)
1. Yêu cầu đã cài sẵn aws CLI để thiết lập profile tại máy local
2. Upload 1 file bất kì lên S3
3. Phát hành 1 Presign url cho object trên S3 bằng command
4. Sử dụng URL để download file trên trình duyệt
5. Đợi hết thời gian hiệu lực của url, thử lại => expired

-> Connect CLI to S3 -> up thử 1 file -> use command: "aws s3 presign [S3Uri] --expires-in [time=second]" -> Copy URL to browser 