
output "my_instance_id_webserver" {
  value = aws_instance.Jenkins.id
}

output "my_instance_id_TomCat" {
  value = aws_instance.TomCat.id
}
output "aws_security_group" {
  value = aws_security_group.my_servers.id
}
