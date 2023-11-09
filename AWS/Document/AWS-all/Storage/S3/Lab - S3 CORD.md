# CORS là gì?
- CORS là một cơ chế cho phép nhiều tài nguyên khác nhau (fonts, Javascript, v.v…) của một trang web có thể được truy vấn từ domain khác với domain của trang đó. CORS là viết tắt của từ Cross-origin resource sharing.

# S3 thì liên quan gì đến CORS ?
- Trong bài lab này, chúng ta thực hành CORS trên 2 S3 static website
- Chuẩn bị:
    + 1 S3 static web gồm 2 file: index.html và users.json
    + 1 S3 static web gồm 1 file: users.json
- Nội dung file index.html:
```
<!DOCTYPE html>
<html>
<body>
<div class="container"></div>
</body>
<script>
async function getUsers() {
    let url = 'users.json';
    try {
        let res = await fetch(url);
        return await res.json();
    } catch (error) {
        console.log(error);
    }
}

async function renderUsers() {
    let users = await getUsers();
    let html = '';
    users.forEach(user => {
        let htmlSegment = `<div class="user">
                            <img src="${user.profileURL}" >
                            <h2>${user.firstName} ${user.lastName}</h2>
                            <div class="email"><a href="email:${user.email}">${user.email}</a></div>
                        </div>`;

        html += htmlSegment;
    });

    let container = document.querySelector('.container');
    container.innerHTML = html;
}

renderUsers();
</script>

</html>
```

- File users.json ở 2 bucket có nội dung giống nhau:
```
[
    {
        "username": "john",
        "firstName": "John",
        "lastName": "Doe",
        "gender": "Male",
        "profileURL": "img/male.png",
        "email": "john.doe@example.com"
    },
    {
        "username": "jane",
        "firstName": "Jane",
        "lastName": "Doe",
        "gender": "Female",
        "profileURL": "img/female.png",
        "email": "jane.doe@example.com"
    }
]
```


- Step 1: Mở static web 1 trên trình duyệt, lúc này trang web load bình thường. File index.html sử dụng Fetch API để lấy dữ liệu từ file users.json trên cùng 1 bucket, nói cách khác thì file index.html và users.json có cùng origin
- Step 2: Mở file users.json ở static web 2 và copy url trỏ đến file users.json
- Step 3: Update file index.html ở bucket 1, thay đoạn let url = 'users.json'; bằng đoạn
    + Thay vì load file users.json từ bucket 1 thì chúng ta sẽ lấy file users.json từ bucket 2. Lưu ý chỗ url này các bạn thay bằng url tương ứng với bucket các bạn tạo
- Step 4: Upload file index.html lên bucket 1 và mở lại trang web
    + Lúc này web bị lỗi CORS: file index.html từ bucket 1 đang thực hiện Fetch API đến file users.json nằm ở domain của static web 2. Để có thể thực hiện cross-origin request này, ta cần cấu hình CORS policy ở bucket 2
- Step 5: Ở bucket 2, tab Permission, scroll xuống phần cấu hình CORS và điền policy sau:
```
[
    {
        "AllowedMethods": [
            "GET"
        ],
        "AllowedOrigins": [
            "http://bucket-1-515462467908.s3-website-ap-southeast-1.amazonaws.com"
        ]
    }
]
```
>Policy này cho phép các resource nằm ở domain http://bucket-1-515462467908.s3-website-ap-southeast-1.amazonaws.com thực hiện GET request đến các resource ở bucket 2. Các bạn lưu ý thay statc web url của bucket 1 của các bạn vào.

- Step 6: Mở lại static web 1 để kiểm tra
    + Trang web load thành công, server response cho thấy domain static web 2 cho phép domain bucket 1 thực hiện GET request