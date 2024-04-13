output "aws_vpc_id" {
  value       = aws_vpc.vpc.id
}

output "aws_default_vpc" {
  value       = data.aws_vpc.default_vpc.id

}

output "aws_subnet_public_ids" {
  value       = aws_subnet.public[*].id

}


output "aws_subnet_private_ids" {
  value       = aws_subnet.private[*].id

}


output "aws_subnet_database_ids" {
  value       = aws_subnet.public[*].id

}
