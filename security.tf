# Create security group
resource "aws_security_group" "web_access" {
  name_prefix = "web_access"
  vpc_id      = "${aws_vpc.my_vpc.id}"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.myip] # Allow SSH traffic from a specific IP (variable stored in Terraform Cloud)
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from anywhere
  }
  
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8"] # Allow ICMP traffic from CIDR block 10.0.0.0/8
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound ICMP traffic to anywhere
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound HTTP traffic to anywhere
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound HTTPS traffic to anywhere
  }
  
  tags = {
    Name = "web_access"
  }
}

