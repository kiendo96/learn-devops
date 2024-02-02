# Terraform Output Values


# EC2 Instance Public IP with TOSET
output "instance_publicip" {
  description = "EC2 Instance Public IP"
#   value = aws_instance.myec2vm.*.public_ip ==> Legacy Splat
#   value = aws_instance.myec2vm[*].public_ip  # Latest Splat
  value = toset([for instance in aws_instance.myec2vm: instance.public_ip])
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
    description = "EC2 Instance Public DNS"
    value = toset([for instance in aws_instance.myec2vm: instance.public_dns])
}

