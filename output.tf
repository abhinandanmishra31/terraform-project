resource "aws_vpc" "aws-vpc" {
  cidr_block       = "172.30.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "aws-vpc"
  }
}
output "cidr" {
    value = aws_vpc.aws-vpc.cidr_block  
}
output "vpc-id" {
  value = aws_vpc.aws-vpc.id
}
output "vpc-tendancy" {
  value = aws_vpc.aws-vpc.instance_tenancy
}
