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
