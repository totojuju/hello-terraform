resource "aws_security_group" "ecs" {
    name = "hello-ecs-sg"
    description = "Security group for ECS tasks"
    vpc_id = aws_vpc.hello_vpc.id

    ingress {
        description     = "Allow traffic from ALB"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        security_groups = [aws_security_group.alb.id]
    }

    # アウトバウンド：外へ全部OK（NAT経由）
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "hello-ecs-sg"
    }
}

resource "aws_security_group" "alb" {
    name = "hello-alb-sg"
    description = "Security group for ALB"
    vpc_id = aws_vpc.hello_vpc.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = var.allowed_cidrs
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = var.allowed_cidrs
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "hello-alb-sg"
    }
}
