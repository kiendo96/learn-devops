# Lab - S3 static website hosting
1. Chuẩn bị 1 bộ source HTML tĩnh (Có thể là static files build ra từ Agular/Nodejs)
2. Upload source lên s3 (file index.html phải ở level gốc)
3. Bật S3 static website hosting
4. Cấu hình open public access cho bucket
5. Cấu hình bucket policy cho phép mọi người access
6. Test truy cập từ trình duyệt

### Guide
```
Download a source => Up nó lên 1 bucket của s3 -> Access bucket choose "Properties" -> Enable static website hosting -> Nhập "index.html" tại option "index document" => "Error document" chọn vị trí của file error.html
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
```

# Detail
If you don’t have your own static website yet, you can choose one from https://www.free-css.com/free-css-templates

### 1. Enable “Static website hosting” feature
Your bucket > Properties > Static website hosting: Enable

### 2. Configure an index document
It is the home or default page of the website, usually it is index.html

### 3. Update permissions
- Clear “Block all public access” configuration
- Your bucket > Permissions > Block public access (bucket settings): turn off all options of block
- Update your S3 bucket policy
```
{
    "Version": "2012-10-17",
    "Statement": [
       {
           "Sid": "PublicReadGetObject",
           "Effect": "Allow",
           "Principal": "*",
           "Action": [
               "s3:GetObject",
               "s3:GetObjectVersion"
           ],
           "Resource": [
               "arn:aws:s3:::<your_bucket>/*"
           ]
       }
   ]
}
```
### 4. Try accessing to your Bucket website endpoint