resource "aws_lb" "hello" {
    name = "hello-alb"
    load_balancer_type = "application"
    internal = false
    security_groups = [aws_security_group.alb.id]
    subnets = aws_subnet.public[*].id

    tags = {
        Name = "hello-alb"
    }
}

resource "aws_lb_target_group" "hello" {
    name = "hello-ecs-tg"
    port = 8080
    protocol = "HTTP"
    vpc_id = aws_vpc.hello_vpc.id
    target_type = "ip"

    health_check {
        path = "/health"
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 5
        interval = 30
        matcher = "200"
    }

    tags = {
        Name = "hello-ecs-tg"
    }
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.hello.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.hello.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-TLS13-1-2-Res-PQ-2025-09"
    certificate_arn = aws_acm_certificate_validation.hello.certificate_arn

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.hello.arn
    }
}
