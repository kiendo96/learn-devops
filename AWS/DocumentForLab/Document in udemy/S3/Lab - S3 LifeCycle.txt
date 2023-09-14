//Lab - S3 Life Cycle
1. Tạo 1 life cycle rule move object trong 1 folder
  VD: /images xuống Glacier sau 90 ngày
2. Tạo 1 life cycle rule xóa hoàn toàn object trong /image sau 270 ngày

//Tạo 1 lifecycle rule sử dụng để move object từ storage class standard -> glacier flexibal retrieval
=> Access bucket 
    -> Management 
        -> Create life cycle rule 
            -> "Chọn scope và đặt prefix + chọn lifecycle rule actions" 
            VD:
                Choose:
                    Move current versions of objects between storage classes
                    Move noncurrent versions of objects between storage classes
                
                => Khi chọn current versions and noncurrent thì cần chỉ định cho nó biết là nó sẽ chuyển thành loại storage class nào => Ví dụ Glacierr Flexible Retrieval hoặc Glacier Instant Retrieval chẳng hạn



//Tạo 1 lifecycle rule sử dụng để delete object
> Access bucket 
    -> Management 
        -> Create life cycle rule 
            -> "Chọn scope và đặt prefix + chọn lifecycle rule actions" 

*Các option lifecycle delete của S3
- Expire current versions of object: Đối với bucket enble versioning, S3 sẽ add 1 delete marker và current version của object sẽ retained  như 1 noncurrent. Đối với non-version thì S3 sẽ xóa vĩnh viễn object
    => Chúng ta sẽ cần chọn ngày hết hạn sau khi khởi tạo khi enable option này

- Permanently delete noncurrent versions of objects: Chọn ngày sẽ xóa noncurrent versions và được phép giữ lại bao nhiêu version mới nhất. Tối đa 100
- Delete expired object delete markers or incomplete multipart uploads: Xóa các object có delete markers hết hạn hoặc xóa các multipart uploads chưa hoàn thiện

