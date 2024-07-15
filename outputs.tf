output "Jenkins_Master_Public_IP" {
  value = aws_instance.jenkins_master.public_ip
}

output "Jenkins_Master_Private_IP" {
  value = aws_instance.jenkins_master.private_ip
}

output "Jenkins_Slave_Public_IP" {
  value = aws_instance.jenkins_slave.public_ip
}

output "Jenkins_Slave_Private_IP" {
  value = aws_instance.jenkins_slave.private_ip
}