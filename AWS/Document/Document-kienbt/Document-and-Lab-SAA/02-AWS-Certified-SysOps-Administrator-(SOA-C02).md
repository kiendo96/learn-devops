# Introduction
#### Description
The AWS Certified SysOps Administrator - Associate (SOA-C02) is intended for systems administrators in a systems operations role. This path covers the six key areas that are covered by this certification including
Monitoring, Logging, and Remediation
Reliability and Business Continuity,
Deployment, Provisioning, and Automation
Security and Compliance
Networking and Content Delivery
Cost and Performance Optimization
The information and resources contained in this path will be vital in preparing to take the AWS Certified SysOps Administrator - Associate (SOA-C02).

#### Related Topics
CloudAWSAmazon Web Services

#### Prerequisites
At least one year of experience in deployment, management, and operations on AWS is recommended.

#### What you will learn
-   Introduce the AWS Certified SysOps  
-   Administrator - Associate (SOA-C02) exam
-   Implement scalability and elasticity
-   Create an Amazon Aurora DB Cluster with -   Custom Scaling Policy
-   Implement high availability and resilient environments
-   Create an Auto-scaling Group for a Web Server using a Launch Template
-   Implement backup and restore strategies
-   Implementing Custom Lifecycle Rules and Data Protection on Amazon S3
-   Provision and maintain cloud resources
-   Implement an AWS Fargate Service with Blue/Green Deployment
-   Automate manual or repeatable processes
-   Automate Command Execution for Multiple Amazon EC2 Instances
-   Implement and manage security and compliance policies
-   Manage IAM Group and User Permissions
-   Implement data and infrastructure protection strategies
-   Enable Secure Credential Rotation for Amazon RDS
-   Implement networking features and connectivity
-   Create Connections and Routing Between Multiple VPC's
-   Configure domains, DNS services, and content delivery
-   Serve Static Content using Amazon S3 and CloudFront
-   Troubleshoot network connectivity issues
-   Implement cost optimization strategies
-   Group AWS Resources using the Tag Editor
-   Implement performance optimization strategies
-   Create and Use an EBS Volume Based on Projected IOPS Requirements
-   Navigate the logistics of the examination process
-   Understand the exam structure and question types

## Domain 1: Monitoring, Logging, and Remediation
### AWS SysOps Admin: Implement Scalability and Elasticity
-   Implementing Scalable Architectures Using AWS Auto Scaling
    -   Introduction
    -   Loosely Coupled Architectures
    -   Horizontal and Vertical Scaling
    -   Creating an EC2 Auto Scaling Group
    -   Auto Scaling Policies and Scheduled Actions
    -   Configuring Scaling Policies and Scheduled Actions
    -   AWS Auto Scaling Plans
    -   Review
-   Implementing Scalable and Elastic Databases on AWS
    -   Horizontal and Vertical Scaling with RDS
    -   Scaling an RDS MySQL Deployment
    -   Scaling an Aurora Deployment
    -   Adding Caching to Elastic Applications
    -   Creating an Amazon ElastiCache Cluster
    -   Review

### AWS SysOps Admin: Implement High Availability and Resilient Environments
-   Implementing Highly Available Architectures on AWS
    -   Introduction
    -   AWS Global Infrastructure
    -   Elastic Load Balancing and Auto Scaling Groups
    -   Configuring a Highly Available Web Application
    -   Elastic Load Balancing Health Checks
    -   Self-Healing Resiliency with Auto Scaling
    -   RDS Multi-AZ Deployments
    -   Fault Tolerant File Systems
    -   Review
-   Implementing Resilient Environments on AWS with Route 53
    -   Route 53 Health Checks
    -   Route 53 Routing Policies
    -   Configuring Failover Routing in Route 53
    -   Simulating a Regional Outage
    -   Review

### AWS SysOps Admin: Implement Backup and Restore Strategies
-   Automating Snapshots and Backups in AWS
    -   Understanding Concepts and Terminology
    -   Working with Data Lifecycle Manager
    -   Demo: Data Lifecycle Manager
    -   Working with AWS Backup
    -   Demo: AWS Backup
-   Restoring Databases with AWS
    -   Restoring Databases with AWS
    -   Restoring to a Point in Time
    -   Restoring from a Database Snapshot
    -   Promoting a Read Replica
    -   Understanding Backup and Restore Options in Aurora
-   Implementing Amazon S3 Versioning and Lifecycle Rules
    -   Versioning S3 Buckets
    -   Managing S3 Lifecycles
    -   Demo: Setting up S3 Versioning and Lifecycle Rules
-   Configuring Amazon S3 Cross-region Replication
    -   Understanding Cross-region Replication
    -   DEMO: Setting up S3 Cross-region Replication
-   Executing Disaster Recovery Procedures in AWS
    -   Understanding Disaster Recovery Options
    -   Detecting an Incident
    -   Managing Drift

## Domain 3: Deployment, Provisioning, and Automation
### AWS SysOps Admin: Provision and Maintain Cloud Resources
-   Creating and Managing Amazon Machine Images (AMIs)
    -   Overview of AMIs and EC2 Image Builder
    -   Demo: Creating an Image Pipeline with EC2 Image Builder
    -   Demo: Creating an Image with EC2 Image Builder
    -   Demo: Managing and Deleting AMIs
-   Creating, Managing, and Troubleshooting in AWS CloudFormation
    -   Understanding CloudFormation Concepts
    -   Basics of a CloudFormation Template
    -   Demo: Deploying a CloudFormation Template
    -   Demo: Updating a CloudFormation Stack
    -   Working with Multiple CloudFormation Stacks
    -   Troubleshooting CloudFormation
-   Provisioning Resources Across Multiple AWS Regions and Accounts
    -   Options for Cross-region and Cross-account Provisioning
    -   Working with CloudFormation StackSets
    -   Demo: Deploying a CloudFormation StackSet
    -   emo: Sharing Resources through AWS Resource Access Manager
    -   Working with IAM Cross-account Roles
-   Understanding Different Deployment Types in AWS
    -   Deployment Types and Use Cases
    -   AWS Deployment Services
-   Troubleshooting Deployment Issues in AWS
    -   Overview of Common Deployment Issues
    -   Troubleshooting CloudFormation Deployment Issues

### AWS SysOps Admin: Automate Manual or Repeatable Processes
-   Automating Deployments Using AWS Services
    -   Module Introduction
    -   Elastic Beanstalk - Overview
    -   Elastic Beanstalk - Applications
    -   Demo: Deploying Web and Worker Tiers with Elastic Beanstalk
    -   AWS OpsWorks for Configuration Management
    -   AWS Code* Services - Overview
    -   Demo: Creating a GIT Repository with AWS CodeCommit
    -   Building and Testing with AWS CodeBuild
    -   Deploying Code with AWS CodeDeploy
    -   Continuous Delivery with AWS CodePipeline
    -   Important AWS CloudFormation Concepts
-   Implementing and Scheduling Automation in AWS
    -   Module Introduction
    -   AWS Systems Manager - Patch Manager for Automated Patching
    -   Demo: Patching Our EC2 Instances Using Patch Manager
    -   Automating with Events Using Amazon EventBridge - Overview
    -   Demo: Event Patterns and Scheduled Events
    -   Amazon S3 Event Notifications - Overview
    -   Demo: Triggering Lambda with S3 Event Notifications
    -   Recording Resource History with AWS Config
    -   Demo: Enabling AWS Config
    -   Review

## Domain 4: Security and Compliance
### AWS SysOps Admin: Implement and Manage Security and Compliance Policies
-   Implementing Identity Access Management in AWS
    -   Module Introduction
    -   AWS IAM - Key Concepts
    -   Demo: Putting AWS IAM Best Practices into Action
    -   Auditing via AWS CloudTrail - Overview
    -   Demo: Auditing Your AWS Account with AWS CloudTrail
    -   Review External Access with AWS IAM Access Analyzer
    -   AWS Organizations - Overview
    -   Demo: Implementing AWS Organizations and SCPs
    -   Review
-   Reviewing and Validating Compliance and Security in AWS
    -   Module Introduction
    -   Checking Best Practice Compliance with AWS Trusted Advisor
    -   Demo: Leveraging AWS Trusted Advisor
    -   Intrusion Detection with AWS GuardDuty
    -   Vulnerability and Network Analysis with Amazon Inspector
    -   Resource Configuration History with AWS Config
    -   Demo: Enabling AWS Config

### AWS SysOps Admin: Implement Data and Infrastructure Protection Strategies
-   Implementing Encryption in AWS
    -   Implementing Data Classification
    -   Implementing Key Management in AWS
    -   Demonstration: Working with Key Management in AWS
    -   Implementing Encryption in Transit
    -   Demonstration: Working with AWS Certificate Manager
-   Implementing Secret Management in AWS
    -   Implementing Secret Management in AWS
    -   Demonstration: Working with AWS Secrets Manager
-   Implementing Security Reporting Tools in AWS
    -   Implementing Infrastructure Protection Services in AWS
    -   Demonstration: Working with AWS Config and Amazon Inspector
    -   Implementing Threat Detection in AWS
    -   Demonstration: Working with Amazon GuardDuty

## Domain 5: Networking and Content Delivery
### AWS SysOps Admin: Implement Networking Features and Connectivity
-   Implementing Amazon Virtual Private Cloud (VPC)
    -   Identifying Amazon VPC Components
    -   Demo: Implementing Amazon VPC
    -   Implementing Network ACLs and Security Groups
    -   Demo: Implementing Network ACLs and Security Groups Part 1
    -   Demo: Implementing Network ACLs and Security Groups Part 2
-   Implementing VPC Connectivity on AWS
    -   Implementing VPC connectivity
    -   Demo: Working with VPC Peering and Endpoints
    -   Implementing AWS Systems Manager Session Manager
-   Implementing Amazon VPC Protection Services
    -   Implementing AWS Network Protection Services
    -   Demo: Working with AWS Network Protection Services

### AWS SysOps Admin: Configure Domains, DNS Services, and Content Delivery
-   Configuring DNS in AWS
    -   Introduction and Certification Coverage
    -   DNS Overview
    -   DNS Options in AWS
    -   Amazon Provided Zones
    -   Private Hosted Zones
    -   Demonstration Overview
    -   Setting up the Demo VPC
    -   Creating a Private Hosted Zone
    -   Creating a Resource Record Set
    -   Private DNS Servers
    -   Route 53 Resolvers and Endpoints
    -   Examining Resolver Endpoints
    -   Creating Resolver Endpoints
    -   Creating a Forwarding Rule
-   Configuring Amazon Route 53
    -   Route 53 Concepts
    -   Domain Registration and Transfer
    -   Demonstration Overview
    -   Registering a Domain in Route 53
    -   Route 53 Record Types
    -   Route 53 Alias Records
    -   Routing Policies Overview
    -   Simple Routing Policy
    -   Creating Simple Records in Route 53
    -   Creating an Alias Record in Route 53
    -   Failover Routing Policy and Health Checks
    -   Weighted and Multivalue Routing Policies
    -   Geolocation Routing Policy
    -   Creating Geolocation Records in Route 53
    -   Geoproximity Routing and Traffic Flow
    -   Latency Routing Policy
-   Hosting Static Websites on Amazon S3
    -   S3 Overview
    -   Static Websites on S3
    -   S3 Website Setup
    -   Demonstration Overview
    -   Configuring a Static Website on S3
    -   Route 53 for an S3 Website
    -   Adding an Alias Record for an S3 Website
-   Using Amazon CloudFront
    -   CloudFront Overview
    -   CloudFront Components
    -   Securing Access to Content
    -   Demonstration Overview
    -   Creating an Origin Access Identity
    -   Creating a Certificate for Custom Domains
    -   Validating the Certificate
    -   Creating the CloudFront Distribution
    -   Route 53 with CloudFront
    -   Creating Alias Records for CloudFront

### AWS SysOps Admin: Troubleshoot Network Connectivity Issues
-   Identifying Network Configuration Issues in Amazon VPCs
    -   Introduction and Certification Coverage
    -   VPC Core Components
    -   DNS and DHCP
    -   Fundamentals of Connectivity Troubleshooting
    -   Key Connectivity Questions
    -   Connectivity Tracing Example
    -   Demonstration Overview
    -   Deploying the VPC
    -   Deploying the Web Server
    -   Finding Connectivity Information
    -   Checking DNS for EC2
    -   Checking Routing and Network ACLs
    -   Checking Security Group Rules
    -   Networking Traffic Logging
    -   VPC Flow Logs
    -   Configuring VPC Flow Logs
-   Troubleshooting Network Interconnections with Amazon VPCs
    -   VPC Interconnection
    -   VPC Peering Overview
    -   Unsupported Peering Scenarios
    -   Peering Demonstration Overview
    -   Deploying the Peering Connection
    -   Common Peering Errors
    -   Testing the Peering Connection
    -   AWS Tools for Troubleshooting
    -   Using the Reachability Analyzer
    -   VPN Gateway Overview
    -   VPN Routing
    -   Direct Connect Overview
    -   Common VPN and Direct Connect Errors
    -   Transit Gateway Overview
    -   Common Transit Gateway Errors and Tools
    -   Transit Gateway Demonstration Overview
    -   Deploying the Transit Gateway
    -   Testing the Transit Gateway Connections
    -   Using the Reachability Analyzer
    -   Checking the Routing Tables
    -   Fixing the Transit Gateway Routing
-   Troubleshooting Advanced Networking Configurations with AWS VPCs
    -   Load Balancing and Security Overview
    -   Elastic Load Balancers Review
    -   Example Application Load Balancer Configuration
    -   Monitoring Elastic Load Balancers
    -   Troubleshooting Elastic Load Balancers
    -   Application Load Balancer Demonstration Overview
    -   Deploying the Application Load Balancer
    -  Troubleshooting the Deployment
    -   AWS Web Application Firewall Overview
    -   Troubleshooting the AWS WAF
    -  AWS CloudFront Overview
    -   Monitor and Improve Caching

## Domain 6: Cost and Performance Optimization
### AWS SysOps Admin: Implement Performance Optimization Strategies
-   Increasing Efficiency of Computing Resources in AWS
    -   Overview
    -   Forms of Computing in AWS
    -   Choosing the Appropriate EC2 Instance Type
    -   Improving Disk Performance with Instance Store
    -   Enabling Enhanced Networking for EC2 Instances
    -   Grouping EC2 Instances with Placement Groups
    -   Choosing the Appropriate Amazon RDS Database Instance Class
    -   Analyzing Slow SQL Statements with Performance Insights
    -   Improving Read Performance with Read Replicas
    -   Managing Database Connections with RDS Proxy
-   Optimizing Storage Performance in AWS
    -   Choosing the Appropriate Amazon EBS Volume Type
    -   Improving Performance with RAID 0
    -   EBS-optimized EC2 Instances
    -   Monitoring S3 Performance with CloudWatch
    -   Shortening the Distance with S3 Transfer Acceleration
    -   Uploading Large Files with S3 Multipart Upload

### AWS SysOps Admin: Implement Cost Optimization Strategies
-   Managing the Utilization of Resources in AWS
    -   Overview
    -   Visualizing Data with AWS Cost Explorer
    -   Tagging Cost Allocation Resources
    -   Setting Up Alerts with AWS Budgets and Billing Alarms
    -   Optimizing Infrastructure with AWS Trusted Advisor Checks
    -   Evaluating Workloads with AWS Compute Optimizer
    -   Estimating Cost with AWS Pricing Calculator
-   Assessing Resource Usage Patterns in AWS
    -   EC2 Purchasing Options
    -   Reducing Cost with Reserved Instances and Savings Plans
    -   Utilizing Spare Compute Capacity with Spot Instances
-   Transitioning to Managed Services in AWS
    -   Managed Services in AWS
    -   Opportunities to Use Managed Compute Services
    -   Opportunities to Use Managed Storage and Database Services
    -   Opportunities to Use Application and Automation Managed Services