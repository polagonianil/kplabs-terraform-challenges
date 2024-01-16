resource "aws_security_group" "payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  depends_on  = [aws_eip.example]

  # Below ingress allows HTTPS  from DEV VPC
  ingress {
    description = "HTTPS  from DEV VPC"
    from_port   = var.https
    to_port     = var.https
    protocol    = "tcp"
    cidr_blocks = [var.dev-vpc]
  }

  # Below ingress allows APIs access from DEV VPC

  ingress {
    description = "APIs access from DEV VPC"
    from_port   = var.APIs
    to_port     = var.APIs
    protocol    = "tcp"
    cidr_blocks = [var.dev-vpc]
  }

  # Below ingress allows APIs access from Prod App Public IP.

  ingress {
    description = "APIs access from Prod App Public IP"
    from_port   = var.prod-APIs
    to_port     = var.prod-APIs
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.example.public_ip}/32"]
  }
  egress {
    description = "APIs access from Prod App Public IP"
    from_port   = var.splunk
    to_port     = var.splunk
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "payment_app"
    team = "payments-team"
    env = "prod"
  }
}