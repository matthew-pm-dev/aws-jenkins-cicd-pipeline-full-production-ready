output "jenkins_server_instance_id" {
  description = "Jenkins Server EC2 Instance-ID"
  value       = aws_instance.jenkins_server.id
}

output "jenkins_server_console_url" {
  description = "Public DNS URL for the Jenkins admin console"
  value       = "${aws_instance.jenkins_server.public_dns}:8080"
}

