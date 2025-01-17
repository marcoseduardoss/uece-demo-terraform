resource "aws_security_group" "web" {
  name   = "allow_web_traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  name               = "default-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.web.id]
}

resource "aws_lb_target_group" "target_group" {
  name     = "default-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tg_ec2_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.instancia_1.id 
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_ec2_attachment2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.instancia_2.id
  port             = 80
}

resource "aws_lb_listener" "default_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
