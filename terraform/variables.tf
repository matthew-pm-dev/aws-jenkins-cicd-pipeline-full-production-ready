variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1" 
}

variable "jenkins_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "jenkins_ami" {
  description = "EC2 instance type"
  type        = string
  default     = "ami-0de716d6197524dd9"
}

variable "jenkins_scripts_path" {
  description = "Path to the Jenkins scripts directory"
  type        = string
  default     = abspath("${path.module}/../jenkins/scripts")
}
