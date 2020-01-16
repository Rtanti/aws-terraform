# Create web server
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.web_server.id]
  instance_type          = "t2.micro"
  key_name               = var.ssh_key_name
  user_data              = file("userdata.sh")
  tags = {
    Name = var.server_name
  }

  # Save the public IP for testing
  provisioner "local-exec" {
    command = "echo ${aws_instance.web_server.public_ip} > public-ip.txt"
  }

  connection {
    user        = "ubuntu"
    host       = self.public_ip
    private_key = file("~/.ssh/aws-test")
  }

  provisioner "file" {
    source      = "/home/renniet/aws/openpayd/upload"
    destination = "/home/ubuntu"
  }
  
}

resource "aws_launch_configuration" "as_conf" {
  name          = "asg-launch-config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name               = var.ssh_key_name
  user_data              = file("userdata.sh")
  security_groups        = [aws_security_group.asg-server-web.id]
  associate_public_ip_address = true

  #connection {
  #  user        = "ubuntu"
    #host       = aws_launch_configuration.as_conf.instance_id
  #  host       = var.asg_server_name.public_ip
  #  private_key = file("~/.ssh/aws-test")
  #}
  #provisioner "file" {
  #  source      = "/home/renniet/aws/openpayd/upload"
  #  destination = "/home/ubuntu"
  #}
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name                 = "terraform-asg-example"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 2
  desired_capacity     = 2
  max_size             = 10
  vpc_zone_identifier  = ["subnet-183cb154"]
  health_check_type         = "EC2"
  health_check_grace_period	= 200
  wait_for_capacity_timeout = "300s"
  tag  {
   key     = "Name" 
   value   = var.asg_server_name
   propagate_at_launch = true
  }
  

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "bat" {
  name                   = "asg-pol-terraform-test"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this.name

}
