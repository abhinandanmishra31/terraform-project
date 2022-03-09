output "cidr" {
    value = aws_vpc.terraform-vpc.cidr_block  
}
output "vpc-id" {
  value = aws_vpc.terraform-vpc.id
}
output "vpc-tendancy" {
  value = aws_vpc.terraform-vpc.instance_tenancy
}
