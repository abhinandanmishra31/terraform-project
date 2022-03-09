resource "aws_vpc" "my-vpc" {
  cidr_block       = var.vpc
  instance_tenancy = "default"

  tags = {
    Name =var.tags[0]
  }
}
resource "aws_subnet" "uber-pub-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block =var.subnet[0]

  tags = {
    Name =var.tags[1]
  }
}
resource "aws_subnet" "uber-private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.subnet[1]

  tags = {
    Name = var.tags[2]
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.tags[3]
  }
}
resource "aws_route_table" "uber-pub-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.tags[4]
  }
}
resource "aws_key_pair" "uber-key" {
  key_name   = "uber"
  public_key = var.key
}
resource "aws_eip" "lb" {
  instance = aws_instance.web-server.id
  vpc      = true
}
resource "aws_nat_gateway" "uber-nat" {
  allocation_id = aws_eip.lp.id
  subnet_id     = aws_subnet.uber-pub-subnet.id

  tags = {
    Name = var.tags[5]
  }
}
resource "aws_eip" "lp" {
  vpc      = true
}
resource "aws_route_table" "uber-private-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.uber-nat.id
  }
  tags = {
    Name = var.tags[6]
  }
}
resource "aws_route_table_association" "uber-private-asso" {
  subnet_id      = aws_subnet.uber-private-subnet.id
  route_table_id = aws_route_table.uber-private-route.id
}

resource "aws_security_group" "uber-elb-sg" {
  name        = "uber-elb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = var.port[0]
    to_port          = var.port[0]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
 ingress {
    description      = "TLS from VPC"
    from_port        = var.port[2]
    to_port          = var.port[2]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] 
    
  }
  tags = {
    Name = "uber-elb-sg"
  }
}
resource "aws_security_group" "uber-vpn-sg" {
  name        = "uber-vpn-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = var.port[0]
    to_port          = var.port[0]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
 ingress {
    description      = "TLS from VPC"
    from_port        = var.port[2]
    to_port          = var.port[2]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
   ingress {
    description      = "TLS from VPC"
    from_port        = var.port[1]
    to_port          = var.port[1]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
 ingress {
    description      = "TLS from VPC"
    from_port        = var.port[6]
    to_port          = var.port[6]
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
   ingress {
    description      = "TLS from VPC"
    from_port        = var.port[5]
    to_port          = var.port[5]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
 ingress {
    description      = "TLS from VPC"
    from_port        = var.port[4]
    to_port          = var.port[4]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "uber-vpn-sg"
  }
}
resource "aws_security_group" "uber-web-server-sg" {
  name        = "uber-web-server-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id
  
   ingress {
    description      = "Elb-sg"
    from_port        = var.port[0]
    to_port          = var.port[0]
    protocol         = "tcp"
    security_groups  = [aws_security_group.uber-elb-sg.id]
    
    
  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "Elb-sg"
    from_port        = var.port[1]
    to_port          = var.port[1]
    protocol         = "tcp"
    security_groups  = [aws_security_group.uber-elb-sg.id]
    
    
  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "vpn-sg"
    from_port        = var.port[2]
    to_port          = var.port[2]
    protocol         = "tcp"
    security_groups  = [aws_security_group.uber-vpn-sg.id]
    
    
  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  tags = {
    Name = "uber-web-server-sg"
  }
}

resource "aws_security_group" "uber-rds-sg" {
  name        = "uber-rds-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id
  
   ingress {
    description      = "webserver-sg"
    from_port        = var.port[3]
    to_port          = var.port[3]
    protocol         = "tcp"
    security_groups  = [aws_security_group.uber-web-server-sg.id]
    
    
  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "vpn-sg"
    from_port        = var.port[3]
    to_port          = var.port[3]
    protocol         = "tcp"
    security_groups  = [aws_security_group.uber-vpn-sg.id]
    
    
  }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "uber-rds-sg"
  }
}

resource "aws_security_group" "uber-redis-sg" {
  name        = "uber-redis-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id
  
   ingress {
    description      = "webserver-sg"
    from_port        = var.port[8]
    to_port          = var.port[8]
    protocol         = "tcp"
    security_groups  = [aws_security_group.uber-web-server-sg.id]
 }

  egress {
    from_port        = var.port[7]
    to_port          = var.port[7]
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  
  tags = {
    Name = "uber-redis-sg"
  }
}
resource "aws_instance" "web-server" {
  ami           = var.image[0]
  instance_type = var.instancetype[0]
  key_name   = "uber"
  subnet_id = aws_subnet.uber-pub-subnet.id
  vpc_security_group_ids =[aws_security_group.uber-web-server-sg.id]
  tags = {
    Name = var.tags[7]
  }
}
