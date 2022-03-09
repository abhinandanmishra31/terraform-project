resource "aws_vpc" "terraform-vpc" {
  cidr_block       = "172.30.0.0/16"
  instance_tenancy = "default"

  tags = local.common_tags
}
resource "aws_subnet" "terraform-pub-subnet" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "172.30.0.0/24"

  tags = local.common_tags
}
resource "aws_security_group" "terraform-sg" {
  name        = "terraform-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.terraform-vpc.id
  
   ingress {
    description      = "web-sg"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
 }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
}
tags = local.common_tags
}
resource "aws_instance" "web-server" {
  ami           = "ami-033b95fb8079dc481"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.terraform-pub-subnet.id
  vpc_security_group_ids =[aws_security_group.terraform-sg.id]
  tags = local.common_tags
}
locals {
  common_tags={
      Name="terraform-project"
      owner= "abhinandan"
  }
}
