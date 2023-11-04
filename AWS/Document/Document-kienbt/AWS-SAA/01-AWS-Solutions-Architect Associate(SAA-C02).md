# Introduction 
The cloud has taken over the preferred hosting location for enterprise. Amazon Web Services (AWS) dominates this space as the first company that offered cloud-base services at a large scale. Organization are migrating to AWS because it allows them to become more agile in their product offerings while having a relatively low upfront cose.
The migration from traditional data centers to AWS has increased the need for engineers who understand and specialize in AWS. A great way to show potential employers your knowledge of AWS is to obtain a certification. AWS offers three levels of certifications: foundational, associate, and professional. The AWS Solutions Architect Associate certification falls in the middle and validates the certification holder's knowledge in designing solutions in AWS. Below you will learn more about what it takes to obtain the AWS Solutions Architect Associate certification

# Who is the certification for? 
The AWS Solutions Architect Associate is for those who are eager to prove and validate their skills in AWS. It's targeted at sysadmins and systems and DevOps engineers looking to design cloud-hosted solutions and leverage the capabilities of the AWS cloud.

# Purpose 
This associate-level certification from AWS will validate an individual's knowledge of various AWS services including, but not limited to, EC2, S3, and RDS. It will guide an engineer's understanding of the AWS environment while adhering to the AWS Well-Architected Framework when creating resources in the AWS cloud. It provides an introductory glimpse into designing solutions within AWS.

# Applicable Exams
As of this writing, there are two AWS exams that will satisfy the AWS Solutions Architect Associate certification: SAA-C01 and SAA-C02. SAA-C01 is the legacy exam version and is slated to be retired on July 1, 2020. SAA-C02 was introduced on March 23, 2020 and is the replacement for SAA-C01. At a glance they are similar to each other in terms of content with the exception of domain five: Define Operationally Excellent Architectures. In SAA-02, domain five has been eliminated and incorporated into the other four sections. (See Skills Measured section for more on domains.)
If you you can complete your AWS Solutions Architect Associate studies before July 1, the SAA-C01 will still be a valid option for you to complete. If not, then SAA-C02 would be a better option to pursue. If you accomplish the AWS Solutions Architect Associate certification by writing the SAA-C01 exam, your certification will still be valid for three years.

# Prerequisites
There is no prerequisite exam or certification to take the Solutions Architect Associate certification exam. If you want to skip the Cloud Practitioner certification and head straight into the Solutions Architect Associate you are more than welcome to do so.
AWS recommends that candidates have a minimum of one year of hands-on experience working with AWS. However, the lack of experience could be supplemented with on-demand lectures and self-experimentation of AWS services. The key to passing is doing hands-on labs within AWS.
A strong foundation in Linux would be highly beneficial because it's the popular operating system within AWS; AWS even has its own Linux distribution.
Knowing the basics of networking, especially how subnets work, will go a long way. A strong comfort in basic networking is key, because setting up VPC involves knowledge of routes, subnets, and rules. Think of AWS as an abstracted data center--you don't need worry about the underlying hardware, however resources still need to interact with each other, and networking provides that in AWS.
A knowledge of virtualization is important because the same concepts used in on-premises solutions (VMWare, Citrix, Xen) will also apply in AWS. Virtualization is at the core of AWS; understanding how virtual machines or instances are used will enable users to maintain their EC2-based ecosystem.

# Skills Measured
The exam will question your knowledge in a wide range of AWS services such as VPC, EC2, RDS, S3, and more. You will be measured on how well you can utilize offerings and deploy them within AWS. There are four or five domains that topics will be grouped under, depending on the exam. These domains will follow the Well-Architected Framework closely.
In SAA-C01 you will be tested on five domains:

1.  Designing Resilient Architectures
2.  Define Performant Architectures
3.  Specify Secure Applications and Architectures
4.  Design Cost-Optimized Architectures
5.  Define Operationally Excellent Architectures

In SAA-C02 you will be tested on four domains:
1.  Design Resilient Architectures
2.  Design High-Performing Architectures
3.  Design Secure Applications and Architectures
4.  Design Cost-Optimized Architectures

As mentioned previously, domain five in SAA-C01 is lacking in SAA-C02. SAA-C02 has been streamlined to better address operational excellence in other domains.

# Other Resources
The AWS Whitepapers are a phenomenal resource. They provide insights on how to run your apps in the cloud in a resilient and cost-effective manner. These can provide a basis on how test creators craft their exams.One such whitepaper to take note of is the AWS [Well-Architected Framework](https://d1.awsstatic.com/whitepapers/architecture/AWS_Well-Architected_Framework.pdf?did=wp_card&trk=wp_card). This whitepaper provides best practices to keep in mind when designing a solution in AWS. This is an important whitepaper because it enshrines the core pillars to be successful within AWS. As briefly stated before in the Skills Measured section, the domains are structured to address these five pillars:
1. Operational Excellence
2. Security
3. Reliability
4. Performance Efficiency
5. Cost Optimization﻿
If the solution you are designing takes these pillars into account, it is guaranteed to be successful in terms of reliability, performance, and cost within the AWS cloud.

# Position in Broader Certification Path
The AWS Solutions Architect Associate is one of three associate-level certifications within AWS. It sits in the middle of the Solutions Architect certification path.
The skills learned will give you a strong base for the AWS Solutions Architect Professional certification, if you choose to pursue it in the future. Not only that, but it will also allow you to create solutions that can take advantage of AWS's high performance, elasticity, and resilience.
Even though the emphasis of this certification is designing solutions, the knowledge gained can also be used to build upon and achieve other certifications such as the Developer Associate and SysOps Associate certifications.

## Outline :
## Part 1 : Design Resilient Architectures

### Architecting for Reliability on AWS
-   Overview
-   Architecting for Availability
    -   Defining Reliability, Resiliency, and Availability
    -   Architecting for 99.9% Availability
    -   Loose Coupling
    -   Simple Queue Service
    -   Elastic Container Service
    -   Cloud Native Applications
    -   Trusted Advisor
    -   Key Takeaways
-   Setting up Your AWS Environment
    -   Module Introduction
    -   Avoiding a Big Bill by Using AWS Budgets
    -   Creating an IAM Password Policy
    -   Protecting the Root User Using Multi-factor Authentication (MFA)
    -   Creating an Administrative User
    -   CloudTrail Event History
    -   Configuring the AWS Command Line Interface (CLI)
    -   Creating a TLS Certificate Using ACM
    -   Summary
-   Building Virtual Private Cloud (VPC) Networks
    -   Module Introduction
    -   Allocating an Elastic IP Address
    -   Global Accelerator
    -   Creating a VPC
    -   Creating Public and Private Subnets
    -   Launching an Instance into a Public Subnet
    -   Launching an Instance into a Private Subnet
    -   Direct Connect and Transit Gateway
    -   Connecting VPCs Using a Transit Gateway
    -   Summary
-   Automated Deployments with CloudFormation
    -   Module Introduction
    -   Reviewing the CloudFormation Templates
    -   Application Load Balancers
    -   Auto Scaling Groups
    -   Deploying the Stack
    -   Deleting the Stack
    -   Summary
-   Multi-region Applications with Route 53
    -   Module Introduction
    -   Deploying a Multi-region Application
    -   Active-active Redundancy Using Weighted Resource Records
    -   Active-passive Redundancy Using Failover Resource Records
    -   Route 53 Health Checks
    -   Summary

## Part 2: Design High-Performing Architectures

### Architecting for Performance Efficiency on AWS
-   Overview
-   Understanding the Design Principles
    -   Introduction
    -   Why Move to the Cloud?
    -   General Design Principles
    -   Review
-   Considering Compute Performance Options
    -   AWS Compute
    -   EC2 Performance
    -   ECS Performance
    -   AWS Lambda Performance
    -   Demo - Researching AWS Compute Options
    -   Applying Our Knowledge
    -   Review
-   Reviewing Storage Performance Options
    -   AWS Storage
    -   S3 Performance
    -   Glacier Performance
    -   EBS Performance
    -   EFS Performance
    -   Demo - Researching AWS Storage Options
    -   Applying Our Knowledge
    -   Review
-   Examining Database Performance Options
    -   AWS Databases
    -   RDS Performance
    -   DynamoDB Performance
    -   Redshift Performance
    -   Demo - Researching AWS Database Options
    -   Applying Our Knowledge
    -   Review
-   Evaluating Network Performance Options
    -   AWS Networking
    -   Regions and Availability Zones
    -   Edge Locations
    -   Route 53
    -   What's New with AWS?
    -   Applying Our Knowledge
    -   Review
-   Preparing to Improve Your Architecture
    -   Preparing to Improve Your Architecture
    -   The CI/CD Process
    -   Understanding CloudFormation
    -   Introducing CloudFormation Templates
    -   AWS Architecture Resources
    -   Review
-   Monitoring Your Architecture
    -   Monitoring Your Architecture
    -   Using CloudWatch for Monitoring
    -   Setting up a CloudWatch Log
    -   AWS - The Big Picture
    -   Review
-   Understanding the Trade-offs
    -   Understanding the Trade-offs
    -   Patterns for Trade-offs
    -   Reviewing the Trade-offs
    -   Review

## Part 3: Design Secure Applications and Architectures
### Architecting for Security on AWS
-   Overview
-   Protecting AWS Credentials
    -   Confidentiality, Integrity, and Availability
    -   Overview
    -   Understanding AWS Credentials
    -   Locking Down the Root User
    -   Introduction to Principals and Policies
    -   Understanding Policies
    -   Creating an Administrative User
    -   Using Groups
    -   Denying Access with User Policies
    -   Denying Access with Group Policies
    -   Summary
-   Capturing and Analyzing Logs
    -   Introduction to Capturing and Analyzing Logs
    -   Understanding CloudTrail
    -   Configuring CloudTrail to Log AWS Service Operations
    -   CloudTrail vs. CloudWatch Logs
    -   Configuring CloudWatch Logs
    -   Reading CloudTrail Logs Using CloudWatch Logs
    -   Creating CloudWatch Alarms
    -   Searching Logs with Athena
    -   Tracking Configuration Changes in AWS Config
    -   Summary
-   Protecting Network and Host-level Boundaries
    -   Introduction to Protecting Network and Host-level Boundaries
    -   Creating a Public Subnet
    -   Creating and Using an IAM Instance Profile
    -   Using SSH Key Pairs
    -   Using VPC Endpoints - Part 1
    -   Using VPC Endpoints - Part 2
    -   Network Access Control Lists
    -   Summary
-   Protecting Data at Rest
    -   Introduction to Protecting Data at Rest
    -   Creating a Customer Master Key with KMS
    -   Encrypting an Unencrypted EBS Volume
    -   S3 Access Permissions - Part 1
    -   S3 Access Permissions - Part 2
    -   CloudFront Origin Access Identity
    -   Granting Anonymous Access with Object ACLs and Bucket Policies
    -   Encrypting S3 Objects with KMS-managed Keys (SSE-KMS)
    -   Summary
-   Protecting Data in Transit
    -   Introduction to Protecting Data in Transit
    -   Preparing for the Load Balancer
    -   Creating a Secure Application Load Balancer
    -   Summary
-   Configuring Data Backup, Replication, and Recovery
    -   Introduction to Data Backup, Replication, and Recovery
    -   Versioning
    -   Lifecycle Management
    -   Cross-region Replication
    -   Summary

## Part 4: Design Cost-Optimized Architectures
### Make Cost-Optimized Decisions on AWS
-   Overview
-   Understanding Cost Effective Storage in AWS
    -   Understanding S3 Storage Classes
    -   Demonstration: Working with S3 Storage Classes
    -   Understanding S3 Glacier and S3 Glacier Deep Archive
    -   Understanding EBS Storage Options and Pricing
-   Understanding Cost Effective Compute in AWS
    -   Understanding On-Demand, Spot, Reserved, and Scheduled EC2 Instances
    -   Demonstration: EC2 Savings Plans
    -   Right Sizing EC2 to Optimize Costs
    -   Introducing the Cost Saving Benefits of Serverless Compute
-   Understanding Database Pricing and Cost-optimization
    -   Understanding RDS Pricing
    -   Understanding DynamoDB Pricing
-   Understanding Cost-optimized Network Architectures
    -   Understanding How ELB and Auto Scale Can Be Used to Optimize Costs
    -   Understanding VPC Routing and Hybrid Connectivity Decisions to Help Optimize Costs
    -   Implementing Offloading with CloudFront to Reduce EC2 Costs
-   Making Cost-optimized Decisions
    -   Understanding Factors That Can Affect Costs in AWS
    -   Demonstration: Working with AWS Tools to Monitor and Estimate Costs in AWS
    -   Summary

### 
