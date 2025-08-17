variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1" 
}

variable "jenkins_instance_type" {
  description = "EC2 instance type for jenkins server"
  type        = string
  default     = "t3.micro"
}

variable "nexus_instance_type" {
  description = "EC2 instance type for nexus server"
  type        = string
  #default     = "m7i-flex.large"
  default     = "t3.micro"
}

variable "jenkins_ami" {
  description = "Linux 2023 AMI for jenkins server"
  type        = string
  default     = "ami-0de716d6197524dd9"
}

variable "nexus_ami" {
  description = "Linux 2023 AMI for nexus server"
  type        = string
  default     = "ami-0de716d6197524dd9"
}