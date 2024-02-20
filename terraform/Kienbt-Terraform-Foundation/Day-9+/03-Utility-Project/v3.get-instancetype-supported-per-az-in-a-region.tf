data "aws_availability_zones" "myzone" {
  
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ec2_instance_type_offerings" "my_ins_type2" {
  for_each = toset(data.aws_availability_zones.myzone.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}

# Output-1
# Basic Output: All Availability Zones mapped to Supported Instance Types 
output "output_v3_1" {
  value = {
      for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
  }
}

# Output-2
# Filtered Output: Exclude Unsupported Availability Zones

output "output_v3_2" {
    value = {
        for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: 
        az => details.instance_types if length(details.instance_types) != 0
    }
}

output "output_v3_3" {
   value = keys({
        for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: 
        az => details.instance_types if length(details.instance_types) != 0
    })
}