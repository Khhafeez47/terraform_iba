resource "aws_instance" "ubuntu_instance" {
  ami                    = var.ubuntu_ami_id
  instance_type          = var.t2_micro
  subnet_id              = var.us_east_2c
  key_name               = var.key_name
  security_groups        = [aws_security_group.ubuntu_sg.id]
  user_data              = file("${path.module}/userdata/ubuntu_userdata.sh")
  tags = {
    Name = "tf_created_ec2_ubuntu"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
}

resource "aws_instance" "amazon_linux_2_instance" {
  ami                    = var.al2_ami_id
  instance_type          = var.t2_micro
  subnet_id              = var.us_east_2a
  key_name               = var.key_name
  security_groups        = [aws_security_group.amazon_linux_sg.id]
  user_data              = file("${path.module}/userdata/al2_userdata.sh")
  tags = {
    Name = "tf_created_ec2_amazon_linux_2"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
}

resource "aws_instance" "amazon_linux_2023_instance" {
  ami                    = var.al2023_ami_id
  instance_type          = var.t2_micro
  subnet_id              = var.us_east_2b
  key_name               = var.key_name
  security_groups        = [aws_security_group.amazon_linux_sg.id]
  user_data              = file("${path.module}/userdata/al2023_userdata.sh")
  tags = {
    Name = "tf_created_ec2_amazon_linux_2023"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
}
