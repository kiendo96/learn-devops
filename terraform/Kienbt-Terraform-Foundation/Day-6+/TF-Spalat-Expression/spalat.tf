resource "aws_iam_user" "lb" {
  count = 3
  name = "iamuser.${count.index}"
  path = "/system/"
}

output "arns0" {
  description = "Information of users"
  value = aws_iam_user.lb[0].arn
}

output "arns1" {
  description = "Information of users"
  value = aws_iam_user.lb[1].arn
}

output "arns2" {
  description = "Information of users"
  value = aws_iam_user.lb[2].arn
}

output "arns" {
  description = "Information of Users"
  value = aws_iam_user.lb[*].arn
}