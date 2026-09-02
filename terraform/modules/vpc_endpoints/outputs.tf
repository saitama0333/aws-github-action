output "s3_endpoint_id" {
  description = "ID of the S3 Gateway VPC endpoint."
  value       = aws_vpc_endpoint.s3.id
}

output "interface_endpoint_ids" {
  description = "IDs of the interface VPC endpoints."
  value = {
    for name, endpoint in aws_vpc_endpoint.interface :
    name => endpoint.id
  }
}

output "security_group_id" {
  description = "Security group ID attached to interface endpoints."
  value       = aws_security_group.endpoints.id
}