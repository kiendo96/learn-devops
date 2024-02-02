output "bucket_arn" {
  description = "ARN of the bucket"
  value = module.s3_bucket.arn
}

output "bucket_name" {
  description = "Name (if) of the bucket"
  value = module.s3_bucket.name
}

output "bucket_domain_name" {
    description = "Domain name of the bucket"
    value = module.s3_bucket.domain
}

output "bucket_endpoint" {
    description = "Endpoint of the bucket"
    value = module.s3_bucket.endpoint
}