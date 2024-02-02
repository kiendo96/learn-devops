variable "my_bucket" {
    description = "S3 bucket name that was passed to s3 custom module"
    type = string
    default = "buitrungkien-1990"
}
variable "my_tags" {
    description = "Tags to set on the bucket"
    type = map(string)
    default = {
      Terraform = "true"
      Environment = "dev"
      CreatedBy = "devops-team"
    }
}
