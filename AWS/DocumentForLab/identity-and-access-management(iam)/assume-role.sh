#Assume role cli:
aws sts assume-role --role-arn <role-arn> --role-session-name <session-name> 

#Example
aws sts assume-role --role-arn arn:aws:iam::731283760511:role/test-poweruser-role --role-session-name test-assume 
