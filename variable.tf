variable "ami" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = "ami-06445ac85e0d277a9"
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
  default     = "vpc-084a10f473fb0a8bb"
}

variable "key_name" {
  description = "name of the key pair used for SSH access"
  type        = string
  default     = "Ajay_devs"
}

variable "subnet_ids" {
  description = "subnet ID"
  type        = list(string)
  default     = ["subnet-094550475922cd8b7", "subnet-0a5ed46193c043c4c", "subnet-085fe175dbfb2e30f"]

}