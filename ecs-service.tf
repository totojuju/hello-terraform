resource "aws_ecs_service" "hello" {
    name = "hello-service"
    cluster = aws_ecs_cluster.hello.id
    task_definition = aws_ecs_task_definition.hello.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        subnets = aws_subnet.private[*].id
        assign_public_ip = false
        security_groups = [aws_security_group.ecs.id]
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.hello.arn
        container_name = "hello-container"
        container_port = 8080
    }

    depends_on = [aws_lb_listener.http]
}