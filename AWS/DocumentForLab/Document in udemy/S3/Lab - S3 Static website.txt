//Lab - S3 static website hosting
1. Chuẩn bị 1 bộ source HTML tĩnh (Có thể là static files build ra từ Agular/Nodejs)
2. Upload source lên s3 (file index.html phải ở level gốc)
3. Bật S3 static website hosting
4. Cấu hình open public access cho bucket
5. Cấu hình bucket policy cho phép mọi người access
6. Test truy cập từ trình duyệt

=> Download a source => Up nó lên 1 bucket của s3 -> Access bucket choose "Properties" -> Enable static website hosting -> Nhập "index.html" tại option "index document" => "Error document" chọn vị trí của file error.html
    => Access Permission => turn off block all access default of S3
        => Config Bucket Policy cho phép access all 
            Example:
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Sid": "Statement1",
                            "Effect": "Allow",
                            "Principal": "*",
                            "Action": "s3:GetObject",
                            "Resource": "arn:aws:s3:::kiendt-test-s3/*"
                        }
                    ]
                }
        
=> Copy Bucket hosting để access vào static web