# Overview
Trong bài lab này, chúng ta sẽ replicate S3 object sang 1 bucket nằm ở region khác, nhưng vẫn trong cùng 1 AWS account

# Content
### 1. Chuẩn bị 2 buckets
- Source bucket: có sẵn 1 object nằm ở region ap-southeast-1, bật versioning
- Dest bucket: nằm ở region ap-southeast-2, bật versioning
### 2. Create an IAM role
- Chuẩn bị 1 IAM role có quyền replicate object từ source sang dest bucket. IAM role này sẽ được assume bởi S3 service, trao quyền cho S3 service để replicate object từ source sang dest bucket:
- Step 1: Vào service IAM, mục Roles, chọn Create role
- Step 2: Mục Select trusted entity, chọn AWS Service, Use case là S3
- Step 3: Mục Add permissions, có thể chọn AmazonS3FullAccess policy
>Nếu muốn an toàn hơn, chúng ta hãy tạo 1 inline policy mới bằng cách click vào Create policy. Ở giao diện JSON editor, copy paste policy sau, chú ý thay SourceBucket và DestinationBucket bằng tên bucket vừa tạo

```
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetReplicationConfiguration",
            "s3:ListBucket"
         ],
         "Resource":[
            "arn:aws:s3:::SourceBucket"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetObjectVersionForReplication",
            "s3:GetObjectVersionAcl",
            "s3:GetObjectVersionTagging"
         ],
         "Resource":[
            "arn:aws:s3:::SourceBucket/*"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ReplicateTags"
         ],
         "Resource":"arn:aws:s3:::DestinationBucket/*"
      }
   ]
}
```

- Step 4: Bỏ qua phần Tags, đến phần cuối Review policy, đặt tên và mô tả cho policy rồi ấn Create policy
- Step 5: Quay trở lại giao diện tạo Role, tìm và chọn policy mà ta vừa tạo ở bước 4
- Step 6: Click Next, đặt tên cho Role (vd: S3-replicate) rồi Create Role

### 3. Configure source bucket replication
- Step 1: Ở source bucket, trong tab Management, kéo xuống phần Replication rule và click Create replication rule
- Step 2: Đặt tên cho rule, chọn Enable, chọn rule scope là Apply to all objects
- Step 3: Ở phần Destination, chọn Choose a bucket in this account. Click vào Browse S3 và chọn dest bucket tương ứng. Trong mục IAM role, chọn Choose from existing IAM roles và chọn role đã tạo ở B7
- Step 4: Các option còn lại chúng ta không chọn, rồi bấm Save, chúng ta sẽ chỉ replicate các object mới, do đó chọn No, do not replicate existing objects rồi Submit
- Step 5: Sau khi đã có replication rule, chúng ta upload 1 file mới lên source bucket
- Step 6: Kiểm tra ở dest bucket