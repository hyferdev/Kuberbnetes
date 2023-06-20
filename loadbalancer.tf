# Create load balancer
resource "aws_lb" "my_load_balancer" {
  name               = "RedLoad"
  load_balancer_type = "application"
  subnets            = [aws_subnet.my_subnet_1.id, aws_subnet.my_subnet_2.id]
  security_groups    = [aws_security_group.web_access.id]
}

# Create target group
resource "aws_lb_target_group" "my_target_group" {
  name     = "RedServers"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

/* Attach targets to target group (has to be be pointed to nodes)
resource "aws_lb_target_group_attachment" "attachment_1" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.Red1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attachment_2" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.Red2.id
  port             = 80
}
*/

# Create the listener
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

# Adding load balancer to DNS zone A records
resource "aws_route53_record" "my_record" {
  zone_id = var.hzoneid # Set in Terraform Cloud 
  name    = "terraform"

  type    = "A"

  alias {
    name                   = aws_lb.my_load_balancer.dns_name
    zone_id                = aws_lb.my_load_balancer.zone_id
    evaluate_target_health = true
  }
}

