output "jenkins_server_instance_id" {
  description = "Jenkins Server EC2 Instance-ID"
  value       = aws_instance.jenkins_server.id
}

output "jenkins_server_console_url" {
  description = "Public DNS URL for the Jenkins admin console"
  value       = "${aws_instance.jenkins_server.public_dns}:8080"
}

output "nexus_server_instance_id" {
  description = "Nexus Server EC2 Instance-ID"
  value       = aws_instance.nexus_server.id
}

output "nexus_server_console_url" {
  description = "Public DNS URL for the Nexus server"
  value       = "${aws_instance.nexus_server.public_dns}:8081"
}
