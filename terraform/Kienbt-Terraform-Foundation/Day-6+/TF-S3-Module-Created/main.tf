module "s3_bucket" {
    source = "git::http://gitlab.do.class/it-department/it-devops/s3_bucket.git?ref=v1.2"
    bucket_name = var.my_bucket
    tags = var.my_tags
}