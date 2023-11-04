# Lab - Practice storage class
1. Upload 1 file và chọn Storage class là Standard IA (loại data ít khi access nhưng cần có thể truy cập ngay)
2. Upload 1 file và chọn storage class là OneZone IA (Rẻ hơn 20% so với Standard IA, loại data dễ dàng tạo ra vì nó dễ mất)
3. Upload 1 file và chọn storage class là Glacier Instant Retrieval (Rẻ hơn 63% so với S3 standard IA, Loại data cần lưu trữ dài nhưng ít khi sử dụng. Loại này có thể dùng được ngay khi cần).
4. Upload 1 file và chọn storage class là Glacier Flexibal Retrival (Giống Glacier Instant Retrieval, nhưng thời gian access cần từ vài phút tới vài giờ)
  => Đối với thằng glacier flexibal retrival này sau khi upload lên không thể download được ngay -> action -> Initiate restore
          => Đối với option Retrieval tier có 3 mode  => Sau khi chọn mode phải nhập "Number of days that the restore copy is available" số ngày nó sẽ available
                + Bulk retrieval: Đợi 5 -12 tiếng
                + Standard retrieval: đợi 3 đến 5 hours
                + Expedited retrieval: Đợi 1 đến 5 phút khi file nhỏ hơn 250Mb
5. Access 1 file được lưu trữ dưới dạng class Glacier Deep Archie
6. Xóa các file đã upload
