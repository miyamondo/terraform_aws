resource "aws_lb" "stg_menta_alb" {
  name               = "stg-menta-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.stg_menta_alb_sg.id]
  subnets = [
    data.terraform_remote_state.ec2-nw.outputs.stg_menta_public-a_id,
    data.terraform_remote_state.ec2-nw.outputs.stg_menta_public-c_id
  ]

  tags = {
    Nmae = "stg_menta_alb"
  }
}

resource "aws_lb_target_group" "stg_menta_alb_tg" {
  name        = "stgmenta-alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.terraform_remote_state.ec2-nw.outputs.stg_menta_vpc_id

  health_check {
    interval            = 10
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
  tags = {
    Name = "stg_menta_alb_tg"
  }
}

resource "aws_lb_target_group_attachment" "stg_menta_alb_tg_attachment" {
  for_each = {
    app01 = aws_instance.stg_menta_app01.id
    app02 = aws_instance.stg_menta_app02.id
  }
  target_group_arn = aws_lb_target_group.stg_menta_alb_tg.arn
  target_id        = each.value
}

resource "aws_lb_listener" "stg_menta_alb_listener" {
  load_balancer_arn = aws_lb.stg_menta_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.cert.certificate_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.stg_menta_alb_tg.arn
  }
}

resource "aws_lb_listener" "stg_menta_alb_redirect" {
  load_balancer_arn = aws_lb.stg_menta_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
}
