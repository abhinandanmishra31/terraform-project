output "cidr" {
    value = aws_vpc.aws-vpc.cidr_block  
}
output "vpc-id" {
  value = aws_vpc.aws-vpc.id
}
output "vpc-tendancy" {
  value = aws_vpc.aws-vpc.instance_tenancy
}
