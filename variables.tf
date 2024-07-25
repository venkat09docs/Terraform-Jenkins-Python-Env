// name = value
// Data Types: Integer, String, Boolean, List, Dict

variable "aws_region" {
  type = string
  default = "ap-southeast-1"
}

variable "sg_ports" {
  type = list(number)
  default = [ 22, 8080, 5000 ]
}

variable "sg_cidr_block" {
  type = list(string)
  default = [ "0.0.0.0/0" ] 
}

variable "sg_tags" {
  type = map(string)
  default = {
    "Name"  = "Jenkins SG",
    "Env"   = "dev",
    "Owner" = "Rnstech"
  }
}

variable "type_of_instance" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "terraform_key"
}

variable "jenkins_master_tags" {
  type = map(string)
  default = {
    "Name"  = "Jenkins Master",
    "Env"   = "dev",
    "Owner" = "Rnstech"
  }
}

variable "jenkins_slave_tags" {
  type = map(string)
  default = {
    "Name"  = "Jenkins Slave",
    "Env"   = "dev",
    "Owner" = "Rnstech"
  }
}

variable "jenkins_master_script" {
  type = string
  default = "./scripts/jenkins_master.sh"
}

variable "jenkins_slave_script" {
  type = string
  default = "./scripts/jenkins_slave.sh"
}