# Lab: Text To Voice Using AWS Polly
- Deploy an application convert from text to voice

# Topology
```
S3 Text Bucket(file txt) --s3:ObjectCreated:*event--> SNS ---> SQS ---> Lambda(GET s3 text bucket and PutObject) ---> S3 Audio Bucket ---s3:ObjectCreated:*-->SNS -->Email notify
                                                       |                        |
                                                       v                        v
                                                    Email notify              AWS Polly
```
- In this topo:
    + S3 text bucket: Source bucket storage file txt. Client will push file to this bucket
    + SNS(1): After client upgraded file to S3 source. S3 have an event will push to SNS, then SNS will send an email notify and tranfer to SQS. We need set permission for S3 access to SNS
    + SQS: After sqs receive an message from sns. Sqs will process, then convert this message to lambda
    + Lambda: After lambda receive an message from sqs. It will get object in `s3 text bucket`, then lambda will process this file wil AWS Polly. After that, Lambda will Put Object to `S3 Audio Bucket`
    + SNS(2): Then `S3 Audio Bucket` receive a file from `Lambda`. S3 send a message to `SNS`. Then `SNS` will send an email to client. All step is done.