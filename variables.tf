#Variables file used from other configuration files
variable region {
  default = "us-east-2"
}
variable server_name {
  default = "web-server"
}
variable asg_server_name {
  default = "asg_web-server"
}

variable ssh_key_name {
  default = "web-server"
}
#The Machine Image being used, ubuntu
variable ami {
  default = "ubuntu/images/hvm-ssd/ubuntu-disco-19.04-amd64-server-*"
}
