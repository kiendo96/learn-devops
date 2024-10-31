# Notedddd
- Asynchronous, Decoupling = Amazon Simple Queue Service

# Security
- WAF -> `ALB, API GATEWAY & CloudFront`
- SHIELD -> `Route53, CloudFront & AWS Load Balancer`
- RDS provides three storage types: Provisioned IOPS SSD (also known as io1 and io2 Block Express), General Purpose SSD (also known as gp2 and gp3), and magnetic (also known as standard)

# Session Management
- Turn on the sticky sessions feature (session affinity) on the ALB.
- Distributed Session Management: 
  + Deploy an Amazon ElastiCache for Redis cluster to store customer session information
  + A common solution to for this is to leverage an In-Memory Key/Value store such as Redis and Memcached.

> link tham khảo: https://aws.amazon.com/caching/session-management/

# Storage gateway
- Volume Gateway CACHED vs STORED
  + Cached = stores a subset of frequently accessed data locally (low latency access to most recent data)
  + Stored = Retains the ENTIRE ("all file types") in on prem data centre (entire dataset is on premise, scheduled backups to S3 Hence Volume Gateway stored volume is the apt choice)

# Cloudfront and route 53
- Global, Reduce latency, health checks, no failover = Amazon CloudFront
- Global ,Reduce latency, health checks, failover, Route traffic = Amazon Route 53
- Amazon CloudFront -> S3, EC2, ELB(HTTP,HTTPS is only ALB), Lambda@Edge, API Gateway, Route53, AWS Shield, AWS WAF
- AWS Global Accelerator -> Elastic Load Balancing (ALB, NLB), EC2, Elastic Beanstalk, ECS, EKS, Lambda, Route53, VPC


# Instance Scheduler
- The Instance Scheduler on AWS solution automates the starting and stopping of Amazon Elastic Compute Cloud (Amazon EC2) and Amazon Relational Database Service (Amazon RDS) instances.

- This solution helps reduce operational costs by stopping resources that are not in use and starting them when they are needed. The cost savings can be significant if you leave all of your instances running at full utilization continuously.

> https://aws.amazon.com/solutions/implementations/instance-scheduler-on-aws/

# AWS Macie
- Amazon Macie is a security service that uses machine learning to automatically discover, classify and protect sensitive data in the Amazon Web Services (AWS) Cloud. It currently only supports Amazon Simple Storage Service (Amazon S3), but more AWS data stores are planned.
- Macie can recognize any PII or Protected Health Information (PHI) that exists in your S3 buckets. Macie also monitors the S3 buckets themselves for security and access control

### noted

- Lex is like a chatbot so not useful
- Polly converts text to audio (polly the parrot!) so this is wrong
- Amazon Transcribe can convert audio to text
- Amazon Translate can translate text to any language
- Amazon Comprehend can do sentiment analysis reports

# AWS Trasfer family
- Use for SFTP, FTPS, FTP user & clients  ---Push----> data to S3 or AWS EFS
- AWS Transfer Family is a secure transfer service for moving files into and out of AWS storage services, such as Amazon S3 and Amazon EFS.
- AWS Transfer family use for copying large amounts of data to and from AWS storage
- AWS datasync use for copying small amounts of data to and from AWS storage 
