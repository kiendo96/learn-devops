# data "aws_ec2_instance_type_offerings" "my_ins_type2" {
#   for_each = toset(["us-east-1a", "us-east-1b", "us-east-1e"])
#   filter {
#     name   = "instance-type"
#     values = ["t3.micro"]
#   }

#   filter {
#     name   = "location"
#     values = [each.key]
#   }

#   location_type = "availability-zone"
# }

# #Output-1
# output "output_v2_1" {
# #   value = data.aws_ec2_instance_type_offerings.my_ins_type2.instance_types
#   value = toset([for btkien in data.aws_ec2_instance_type_offerings.my_ins_type2: btkien.instance_types])
# }


# #Output-2
# # Create a Map with Key as Availability Zone and value as Instance Type supported
# output "output_v2_2" {
#   value = {
#       for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
#   }
# }