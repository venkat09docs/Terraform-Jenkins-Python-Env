data "aws_ami" "jenkins_instance" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "Jenkins SG"
  description = "Allow SSH & HTTP inbound traffic and all outbound traffic"
  //vpc_id      = aws_vpc.main.id

  
  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = var.sg_cidr_block
    }
  } 

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.sg_cidr_block    
  }

  tags = var.sg_tags
}

resource "aws_instance" "jenkins_master" {
    ami             = data.aws_ami.jenkins_instance.id 
    instance_type   = var.type_of_instance   
    key_name        = var.key_name
    vpc_security_group_ids = [ aws_security_group.jenkins_sg.id ]
    user_data = file(var.jenkins_master_script)

    tags = var.jenkins_master_tags
}

resource "aws_instance" "jenkins_slave" {
    ami             = data.aws_ami.jenkins_instance.id 
    instance_type   = var.type_of_instance   
    key_name        = var.key_name
    vpc_security_group_ids = [ aws_security_group.jenkins_sg.id ]
    user_data = file(var.jenkins_slave_script)

    tags = var.jenkins_slave_tags
}