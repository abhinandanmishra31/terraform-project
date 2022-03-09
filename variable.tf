variable "vpc" {
    default = "172.30.0.0/16"
}
variable "subnet" {
    type= list
default =["172.30.0.0/24","172.30.16.0/24","172.30.64.0/24"]  
}
variable "tags" {
    type=list
    default = ["uber-vpc","user-pub-sub","uber-private-sub","uber-igw","user-pub-rt"
    ,"uber-nat","uber-private-rt","user-webserver"]
}
variable "key" {
    type = string
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDabLZSiLmAn53KxbPEldkMQqCOpNjwr9aXZ7JqcaE8Sn4S+9925RKW63EEpPtbw2nqMLU9jj6XAYG6/Od12oHLhP5F6xXwoI5q379U6KT7ppWgS5gzcL7dUu9UFrBZhUC+8HE/tiBDfRqUZ/G/vERGBapR3Ep4/ZvwR3kxajCi/36hWN5euBunKWlVN5DQ4+DVOLyu+nwzfpvhweei+YE5BgafjtiNcHT8hE33RNro+SawD5rnbUfrBRhemcSyv0Z97jVP+IlxL5qopfzp8y4c4Ie2HVpuph7KUuvlEBWPrJNpJ/jxNV6c1dhtr67qyycf4qJe1kgER0OVVyrY6MDMS8FMUPSaqPk54u3/uOu7Vfy8zirENE8GZfQ/VT06b7dogF9Z9YSvWMyCM2zIwFcEWqoN0MHXnreyksepRONu1puOddzc5qvhPJRVsIPqXaOC0wqZdMJd/0QEsz5FM8zfqR/WR8Q1FhWrgbssxgQ7mHNTpG5e1wCbrn0+A9IO6Z8= abhin@abhinandan-pc"
}
variable "port" {
    type = list
    default=["443","80","22","3306","12320","12321","1194","0","6379"]
}
variable "instancetype" {
    type = list
    default = ["t2.micro","t2.small","t2.nano","t2.large"]
}
variable "image" {
    type = list
     default = ["ami-0c293f3f676ec4f90","ami-0b0af3577fe5e3532","ami-04505e74c0741db8d"]
}
