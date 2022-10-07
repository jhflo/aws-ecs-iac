resource "aws_alb" "alb" {
  name           = "myapp-load-balancer"
  subnets        = aws_subnet.public.*.id
  security_groups = [aws_security_group.alb-sg.id]
}

resource "aws_alb_target_group" "myapp-tg" {
  name        = "myapp-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.test-vpc.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path
    interval            = 30
  }
}

#redirecting all incomming traffic from ALB to the target group
resource "aws_alb_listener" "testapphttp" {
  load_balancer_arn = aws_alb.alb.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.myapp-tg.arn
  }
}

resource "aws_alb_listener" "testapphttps" {
  load_balancer_arn = aws_alb.alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.myapp-tg.arn
  }
}
