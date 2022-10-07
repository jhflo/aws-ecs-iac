variable "aws_region" {
  default     = "us-east-1"
}

variable "az_count" {
  default     = "3"
  description = "Number of availability zones in above region"
}

variable "ecs_task_execution_role" {
  default     = "myECcsTaskExecutionRole"
  description = "ECS task execution role name"
}

variable "app_image" {
  default     = "jorfloba/timeoff-test:latest"
  description = "Docker image to run in this ECS cluster"
}

variable "app_port" {
  default     = "3000"
  description = "Port on the docker image"
}

variable "app_count" {
  default     = "3" 
  description = "numer of docker containers to run"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  default     = "512"
  description = "Fargate instacne CPU units to provision"
}

variable "fargate_memory" {
  default     = "1024"
  description = "Fargate instance memory to provision (in MiB) not MB"
}
