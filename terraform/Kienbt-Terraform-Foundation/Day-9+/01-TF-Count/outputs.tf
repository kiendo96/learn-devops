# Output - For Loop with List
output "for_output_list" {
  description = "For loop with lists"
  value = [for instance in aws_instance.myec2vm: instance.public_dns]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For loop with Map"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
}


# Output - For Loop with Map-Advance

output "for_output_map2" {
  description = "For loop with Map - Advance"
  value = { for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}

# Out - Latest Generalized Splat Operator - Return List

output "latest_splat_instance_publicdns" {
  description = "Generalized Splat Operator"
  value = aws_instance.myec2vm[*].public_dns
}