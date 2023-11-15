# Overview
- Work CloudFront origin access identities (OAIs)
- Trong bài lab này, chúng ta cấu hình OAI cho CloudFront behaviour khi forward request đến 1 S3 bucket origin. Với OAI, các object trong 1 S3 bucket sẽ chỉ có thể được access từ CloudFront behaviour, không thể access trực tiếp
# Chuẩn bị
- Bài lab này sẽ tiếp tục sử dụng các resource được tạo từ bài lab CloudFront behaviour. Nếu chưa có, hãy thực hành lại bài lab CloudFront behaviour
- Nhắc lại bài lab CloudFront behaviour: sau khi thực hành xong, khi truy cập vào CloudFront url, chúng ta có 1 trang web
- Các GET request đến đường dẫn /img/*.jpeg được CloudFront behaviour forward đến S3 bucket chứa ảnh:
- Hiện tại, S3 bucket chứa ảnh đang được để chế độ public. Do đó, thay vì gọi qua đường dẫn CloudFront, người dùng có thể access trực tiếp vào S3 bucket để xem ảnh
# Hướng dẫn chi tiết
- Để tăng tính bảo mật cho S3 bucket này, chúng ta cấu hình OAI cho CloudFront behaviour và chỉnh sửa bucket policy.
- Chỉ cho phép principal là CloudFront OAI thực hiện GetObject và GetObjectVersion
- Step 01: Ở tab Origins, chọn origin trỏ đến S3 bucket chứa ảnh và Edit
- Step 02: Ở mục S3 bucket access, chọn Yes use OAI, rồi click Create new OAI
- Step 03: Quay lại trang chủ CloudFront, chọn menu Origin access identities. Copy OAI ID
- Step 04: Mở giao diện S3, chọn bucket chứa ảnh, bật lại chế độ Block Public Access và update bucket policy:
```
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "PublicRead",
			"Effect": "Allow",
			"Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E267ULFT5VQDAW"
            },
			"Action": [
				"s3:GetObject",
				"s3:GetObjectVersion"
			],
			"Resource": "arn:aws:s3:::img-bucket-515462467908/*"
		}
	]
}
```
- In there:
    + `E267ULFT5VQDAW` là OAI ID. Các bạn hãy thay OAI ID của mình vào
    + `arn:aws:s3:::img-bucket-515462467908` là ARN của bucket chứa image. Các bạn thay ARN của bucket chứa ảnh của mình vào
- Step 05: Sau khi CloudFront đã deploy thay đổi đến các edge location (cột Modified đổi từ trạng thái Modifying sang ghi ngày tháng), mở lại CloudFront url để kiểm tra

- Step 06: Mở lại S3 bucket chứa ảnh, copy Object URL của 1 object bất kỳ và mở trên trình duyệt để kiểm tra. Có thể thấy chúng ta không thể truy cập S3 object một cách trực tiếp như trước khi có OAI.

