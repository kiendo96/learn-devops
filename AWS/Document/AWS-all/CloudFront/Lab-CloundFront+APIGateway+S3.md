# Requirement:
```
- Biết cách host 1 website tĩnh lên S3 bucket
- Biết cách deploy một API đơn giản
```

1. Chuẩn bị 1 website tĩnh deploy lên S3
2. Tạo 1 API Gateway đơn giản, deploy thành 1 stage
3. Tạo CloudFront distribution, đăng ký S3 làm origin (Hoặc tái sử dụng bài lab1)
4. Add thêm origin cho API Gateway
5. Cấu hình behavior phù hợp cho API gateway và S3
6. Cấu hình caching behavior No-cache cho API Gateway
7. Cấu hình forward một header
>VD: "Source" = "CloudFront"

8. Modify code backenđ thử in ra request header
