resource "aws_ecs_task_definition" "hello" {
    family = "hello-task"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = "256"
    memory = "512"
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

    container_definitions = jsonencode([
        {
            name = "hello-container"
            image = var.app_image
            essential = true
            portMappings = [
                {
                    containerPort = 8080
                    protocol = "tcp"
                }
            ]
        }
    ])
}
