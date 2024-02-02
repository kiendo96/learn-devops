resource "null_resource" "name" {
  depends_on = [
    module.ec2_public
  ]
  # Connection Block for Prvisioners to Connect to EC2 Instance
  connection {
    type = "ssh"
    host = aws_eip.bastion_eip.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("private-key/ssh-to-ec2.pem")
  }

  # File Provisioner: Copies the ssh-to-ec2.pem file to /tmp/ssh-to-ec2.pem
  provisioner "file" {
    source = "private-key/ssh-to-ec2.pem"
    destination = "test/ssh-to-ec2.pem"
  }

  # Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/ssh-to-ec2.pem"
    ]
  }

  # Local Exec Provisioner: local-exec provisioner (Creation-Time Provisioner - Triggered during create resource)
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }
  ## Local Exec Provisioners: local-exec provisioner (Destroy-Time Provisioner - Triggered during deletio of Resource)
  /*
  provisioner "local-exec" {
    command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    when = destroy
    #on_failure = continue
  }
  */
}