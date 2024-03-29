#Test credential
aws sts get-caller-identity

#List all s3 bucket
aws s3 ls

#Download file
aws s3 cp <s3 uri> <local destination>

#Upload file
aws s3 cp <local destination> <s3 uri> 

#Lisst file
aws s3 ls <s3://path>

#Using cli with MFA
#Step 1 issue temporary token
aws sts get-session-token --serial-number arn:aws:iam:: --token-code 041321

#Step 2: config credential file.
"C:\Users\<your user name>\.aws\credentials"
#--------------------
[udemy-mfa]
aws_access_key_id = 
aws_secret_access_key = 
aws_session_token = 
#-------------

#Step 3: specify --profile when run command.
aws s3 ls --profile udemy-mfa
aws s3 ls s3://<your-bucket-name>/ --profile udemy-mfa





