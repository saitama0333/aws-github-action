resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb"
  description = "Security group for the Application Load Balancer."
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from internet"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTP to ECS tasks"
    protocol    = "tcp"
    from_port   = var.target_port
    to_port     = var.target_port
    cidr_blocks = [var.vpc_cidr]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-alb"
  }
}

resource "aws_lb" "this" {
  name               = "${var.project_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = values(var.public_subnet_ids)

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name = "${var.project_name}-${var.environment}-alb"
  }
}

resource "aws_lb_target_group" "this" {
  name        = "${var.project_name}-${var.environment}-tg"
  port        = var.target_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    path                = var.health_check_path
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}