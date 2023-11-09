# IAM Role vs S3 Policy

## 1. Create an user
- Access to IAM > Add users:
    + User name: "s3_user"
    + AWS access type: "AWS Management Console access"
    + Attach existing policies directly: "AmazonS3ReadOnlyAccess"
>We login to AWS by the new user, then confirm that we can see buckets and their objects, but cannot put objects.

## 2. Update the bucket policy
- Set the bucket policy to prevent user s3_user see a specific bucket
```
{
    "Version": "2012-10-17",
    "Id": "Policy1659844597434",
    "Statement": [
        {
            "Sid": "Stmt1659844595662",
            "Effect": "Deny",
            "Principal": {
                "AWS": "arn:aws:iam::<account_id>:user/s3_user"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::<your_bucket>"
        }
    ]
}
```
>Confirm that we can’t see the bucket

## 3. Summary
- Lúc này IAM s3_user không còn quyền xem danh sách object của bucket nữa.
- Quyền của IAM s3_user đối với S3 bucket gồm: IAM policy + Bucket policy
    + Ban đầu, chỉ có IAM policy tác động đến IAM user. IAM policy cho phép (explicit ALLOW) s3_user truy cập toàn bộ S3 bucket & object, trong đó tất nhiên bao gồm S3 bucket DOC-EXAMPLE-BUCKET và các object bên trong nó
    + Sau khi S3 bucket DOC-EXAMPLE-BUCKET được gắn bucket policy, policy này không cho phép (explicit DENY) liệt kê object bên trong bucket, và policy này áp dụng với tất cả principal, trong số đó tất nhiên là có IAM s3_user
    + Lúc này, IAM s3_user chịu tác động của cả IAM policy và bucket policy đối với cùng 1 resource (S3 bucket DOC-EXAMPLE-BUCKET), khi đó expicit DENY sẽ được áp dụng