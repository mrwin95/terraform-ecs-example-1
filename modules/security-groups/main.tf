resource "aws_security_group" "alb_security_group" {
  name = "alb security group"
  vpc_id = var.vpc_id

  ingress {
    description = "http access"
    from_port = "80"
    to_port = "80"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https access"
    from_port = "443"
    to_port = "443"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb security group"
  }
}

resource "aws_security_group" "ecs_security_group" {
  name = "ecs security group"
  vpc_id = var.vpc_id

  ingress {
    description = "http access"
    from_port = "80"
    to_port = "80"
    protocol = "TCP"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description = "https access"
    from_port = "443"
    to_port = "443"
    protocol = "TCP"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs security group"
  }
}