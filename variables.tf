variable "azs" {
    description = "List of availability zones"
    type        = list(string)
    default     = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "ap-northeast-1"
}

variable "app_image" {
    description = "ECR image URI with tag"
    type        = string
}
