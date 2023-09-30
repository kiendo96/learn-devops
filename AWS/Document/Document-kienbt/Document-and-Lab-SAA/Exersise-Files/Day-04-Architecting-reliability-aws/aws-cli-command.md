### AWS CLI Commands

-   Get EIP 
```
aws ec2 allocate-address
```
-   Release EIP 
```
aws ec2 release-address --allocation-id eipalloc-0d47bf1294c84eaf4
```
-   Check EIP Add
```
aws ec2 describe-addresses
```
-   Describe Subnet 
```
aws ec2 describe-subnets --filters Name=cidr-block,Values="10.0.11.0/24"
```
-   Launch a new instance
```
aws ec2 run-instances --image-id ami-01d025118d8e760db --subnet-id subnet-0286d0d7f679ac737 --instance-type t3.micro --key-name ccnetkeypair
```
- Associate a EIP to Ec2 
```
aws ec2 associate-address --instance-id i-036a00e797649cba5 --allocation-id eipalloc-0016c8c2129a23448
```
-   Terminate a ec2 instance
```
aws ec2 terminate-instances --instance-ids i-036a00e797649cba5
```

-   Describe NAT-Gateway
```
aws ec2 describe-nat-gateways
```
-   Delete NAT-Gateway
```
aws ec2 delete-nat-gateway --nat-gateway-id nat-0827194f97b639e0d
```

- Create Transit Gateway
```
aws ec2 create-transit-gateway
```

- Create a VPC
```
aws ec2 create-vpc --cidr-block 172.27.0.0/16 --tag-specifications 'ResourceType=vpc, Tags=[{Key=Name,Value=vpc-01}]'
```

- Create Subnet in VPC
```
aws ec2 create-subnet --vpc-id vpc-06b95746480684294 --cidr-block 172.27.1.0/24 --availability-zone us-east-1a
```

- Create Transit GW Attachment
```
aws ec2 create-transit-gateway-vpc-attachment --transit-gateway-id tgw-06966d6bb0e0487ed --vpc-id vpc-06b95746480684294 --subnet-ids subnet-001dd838706816ebb
```
