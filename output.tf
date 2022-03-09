output "cidr" {
    value = aws_vpc.my-vpc.cidr_block  
}
output "vpc-id" {
  value = aws_vpc.my-vpc.id
}
output "vpc-tendancy" {
  value=aws_vpc.my-vpc.instance_tenancy
}
