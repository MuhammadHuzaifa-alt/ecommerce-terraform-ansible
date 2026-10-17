variable "aws_region" {
  description = "aws region for ecommerce infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name from ecommerce resources"
  type        = string
  default     = "ecommerce-neww"
}

variable "vpc_cidr" {
  description = "CIDR block for new vpc"
  type        = string
  default     = "10.30.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.30.1.0/24"
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
variable "ssh_allowed_cidr" {
  description = "Public IPv4 address allowed to connect through SSH"
  type        = string
  default     = "72.255.54.137/32"

  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr)) && tonumber(split("/", var.ssh_allowed_cidr)[1]) == 32
    error_message = "ssh_allowed_cidr must be one IPv4 address with a /32 prefix."
  }
}

variable "root_volume_size" {
  description = "EC2 root volume size in GiB"
  type        = number
  default     = 16
}
