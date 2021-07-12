
output "my_instance_id_webserver" {
  value = aws_instance.Jenkins.id
}

output "my_instance_id_APP" {
  value = aws_instance.APP.id
}
output "aws_security_group" {
  value = aws_security_group.my_servers.id
}
