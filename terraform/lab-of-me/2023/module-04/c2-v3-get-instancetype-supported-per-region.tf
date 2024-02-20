data "aws_availability_zones" "my_azones" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ec2_instance_type_offerings" "my_ins_type" {
  for_each = toset(data.aws_availability_zones.my_azones.names)
  filter {
    name = "instance-type"
    values = [ "t3.micro" ]
  }
  filter {
    name = "location"
    values = [ each.key ]
  }
  location_type = "availability-zone"
}

# output "test" {
#   value = data.aws_availability_zones.my_azones
# }
output "output_v3_1" {
  value = { for az,details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types}
}

output "output_v3_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types if length(details.instance_types) !=0
  }
}

output "output_v3_3" {
  value = keys({
    for az,details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types if length(details.instance_types) != 0
  })
}

output "output_v3_4" {
  value = keys({
    for az,details in data.aws_ec2_instance_type_offerings.my_ins_type: az => details.instance_types if length(details.instance_types) != 0
  })[0]
}