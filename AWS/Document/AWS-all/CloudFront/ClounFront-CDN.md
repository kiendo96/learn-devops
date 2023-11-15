# Content Delivery Network CloudFront
### What is CloudFront
- A web service that speeds up distribution of web content to users
- CloudFront delivers content through `edge locations`
- CloudFront is CDN

### What is CND?
- CDN(Content Delivery Network): Là 1 mạng lưới giúp delivery nội dung tới người dùng cuối một cách nhanh chóng nhờ vào việc điều hướng request của họ tới các máy chủ chứa tài nguyên gần nhất
>Content Delivery Network is a geographically distributed group of servers which work together to provide fast content delivery

# Benefit
- Improving website load times
- Reducing bandwidth costs
- Increasing content availability
- Improving website security (DDoS protection)
>E.g: Cloudflare, Amazon CloudFront, Azure CDN....

# Mô hình hoạt động của 1 mạng CDN
- Khi không có CDN, tài nguyên của server sẽ được deliver tới clinet một cách trực tiếp
  => Tùy vào khoảng cách địa lý mà tốc độ truy cập sẽ nhanh hay chậm
- Khi có CND, tài nguyên server sẽ được cache trên các máy chủ Edge Location, request của user tới một tài nguyên trên CloudFront sẽ được redirect tới máy chủ Edge gần nhất

# Các khái niệm cơ bản của CloudFront
- Distribution: AWS CloudFront phân phối nội dung từ origin đến các Edge Location thông qua 1 distribution. Một distribution định nghĩa cách CloudFront phân phối nội dung, bao gồm địa chỉ origin, các Edge Location được sử dụng, các thiết lập security & caching
- Edge Location: AWS CloudFront sử dụng một mạng lưới toàn cầu các edge location là các điểm đặt máy chủ trên khắp thế giới, để phân phối nội dung đến người dùng ở gần nhất vị trí đó
- Origin: Đây là nơi lưu trữ nội dung gốc(origin content) của bạn, bao gồm các tập tin, ứng dụng web, API và database. Origin có thể là 1 web server, s3 bucket hoặc các dịch vụ aws khác
- Cache: AWS CloudFront lưu trữ các tài nguyên tại edge location để giảm thời gian phản hồi và tăng tốc độ tải trang web. Các tài nguyên ngày bao hồm hình ảnh, file css và javascript
- Logging and Reporting: AWS CloudFront cung cấp các báo cáo về hoạt động của distribution, bao gồm lưu lượng và số lần truy cập
- Security: AWS CloudFront hỗ trợ nhiều tính năng bảo mật, bao gồm kết nối HTTPS, chữ ký số (Certificate) và xác thực người dùng
- Customize at the Edge: Thông qua cơ chế Lambda@Edge, cho phép người dùng thực thi các function trên các sự kiện CloudFront. Lợi thế về tốc độ và hiệu suất so với thực thi ở Origin. Một số use-case có thể kể đến như: Authen/Author, xử lý tính toán đơn giản, SEO, Intelligent routing, AntiBot, Realtime image transformation, A/B Testing, User, prioritilization

# Cách CloudFront deliver content to user
- Step 1: User access website, request một tài nguyên
>VD: HTML file, Image, CSS...

- Step 2: DNS điều hướng request của user tới CloudFront edge location gần nhất (dựa theo độ trễ)
- Step 3:
  + 3.1 - CloudFront forward request tới Origin server (Một HTTP server hoặc s3 bucket)
  + 3.2 - Origin server trả kết quả cho Edge location
  + 3.3 - Ngay sau khi nhận được firstbyte response, edge location forward object tới end-user đồng thời cache lại nội dung cho request lần sau
      >Từ lần thứ 2 trở đi, mặc định edge location sẽ trả về object được yêu cầu mà không gọi tới origin server -> tăng tốc độ truy cập


# Usecase của CloudFront
- CloudFront được sử dụng cho một số usecase sau:
  + Tăng tốc website(Image, CSS, Document, Video,...)
  + On demand video & video streaming
  + Field level encrypt: CloudFront tự động mã hóa data được gửi lên từ người dùng, chỉ backend application có key có thể giải mã
  + Customize at the edge: Trả về mã lỗi khi server maintain hoặc authorize user trước khi forward request tới backend. Cần sử dụng Lambda@Edge
# CloudFront pricing
- CloudFront tính toán chi phí dựa trên các tiêu chí:
  + No Up-front free, người dùng chỉ trả tiền cho những gì sử dụng
  + Lượng data thực tế tranasfer out to internet
  + CloudFront function, Lambda@Edge
  + Invalidation Request(clear cache)
  + Real-time log
  + Field level encrypt

# CloudFront behavior
- Một cloudFront distribution có thể có nhiều hơn 1 Origin server phía sau
>VD: Một hệ thống gồm 1 S3 bucket host static website, 1 backend server gồm ALB+Container muốn sử dụng chung một CloudFront distribution => Cần có cơ chế phân biệt request nào sẽ điều hướng tới đau

- Behavior cho phép định nghĩa request tới các pattern khác nhau sẽ được forward tới các origin khác nhau
- Bằng việc cấu hình các behavior khác nhau, CloudFront giúp điều hướng request của người dùng tới đúng origin mong muốn
>Lưu ý khi setting behavior cần quan tâm tới thứ tự trước sau của các behavior, vì khi match 1 path rồi sẽ không đánh giá path tiếp theo

### Example topology:
```
Client -> Browser(/index.html, /image/xxx, /videos/yyy, /api/login) -> CloudFront with Behaviors:
                                                                                    -> /api/*       -> Backend APi
                                                                                    -> /images/*, /videos/*    -> Media bucket
                                                                                    -> /*           -> Website bucket
```

# CloudFront Cache Policy
- CloudFront cache policy là một cấu hình định nghĩa CloudFront sẽ cache và serves content như thế nào đối với User
- Cache Policy có thể được định nghĩa riêng cho từng distribution hoặc behavior. Một số rule có thể định nghĩa
>VD: Thời gian content được cache, compress hay không? forward cookie và query strings hay không?

- Việc apply caching policy khác nhau cho từng distribution hoặc behavior, cho phép tinh chỉnh việc control caching cho từng URL hoặc request pattern. Việc này giúp tối ưu hóa caching behavior cho từng loại content khác nhau
>VD: Static (image, css, js, video) hoặc dynamic API response

# CloudFront origin request policy
- CloudFront origin request policy được sử dụng để định nghĩa cách CloudFront xử lý request tới origin
- Khi user request content trên CloudFront, request được forward tới các origin như S3, EC2, ALB. Origin Request Policy cho phép modify request trước khi forward tới origin
- Có thể add/modify/remove header hoặc query string để optimize caching, tăng performance. Ngoài ra có thể cấu hình CloudFront sign hoặc encrypt request để bảo vệ backend khỏi những access unauthorized
- Origin request policy hữu dụng khi có kiến trúc backend phức tạp
>VD: Có nhiều loại origin server

# CloudFront Geo Restriction
- Prevent users in specific geographic locations from accessing content
- `Whitelist`: Allow your users to access your content only if they're in one of the countries on a list of approved countries
- `Blacklist`: Prevent your users from accessing your content if they're in one of the countries on a blacklist of banned countries
- The `country` is determined using a 3rd party Geo-IP database
- Use case: Copyright Laws to control access to content

# Origin Access Identity(OAI)
- Definition:
  + Origin Access Identity (AOI) is a special CloudFront user
- Purpose
  + Restrict access to content in S3 buckets
  + Users can only access your file through CloudFront, not directly from the s3 bucket