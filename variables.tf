variable "t2_micro" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ubuntu_ami_id" {
  description = "AMI ID for Ubuntu 20.04"
  type        = string
  default     = "ami-04f167a56786e4b09"
}

variable "al2_ami_id" {
  description = "AMI ID for Amazon Linux 2"
  type        = string
  default     = "ami-0945157a116cd5d12"
}

variable "al2023_ami_id" {
  description = "AMI ID for Amazon Linux 2023"
  type        = string
  default     = "ami-060a84cbcb5c14844"
}

variable "us_east_2c" {
  description = "Subnet ID for Ubuntu instance"
  type        = string
  default     = "subnet-05867417ebe81bd39"
}

variable "us_east_2a" {
  description = "Subnet ID for Amazon Linux 2 instance"
  type        = string
  default     = "subnet-03d19a476c208137d"
}

variable "us_east_2b" {
  description = "Subnet ID for Amazon Linux 2023 instance"
  type        = string
  default     = "subnet-00eca0d83db384589"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "mytestkey"
}
