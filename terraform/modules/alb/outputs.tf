output "load_balancer_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.this.arn
}

output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.this.dns_name
}

output "security_group_id" {
  description = "Security group ID of the Application Load Balancer."
  value       = aws_security_group.alb.id
}

output "target_group_arn" {
  description = "ARN of the ECS target group."
  value       = aws_lb_target_group.this.arn
}