region = "ap-south-1"
vpc_info = {
  cidr_block = "192.168.0.0/16"
  name       = "Project1_VPC"
}
public_subnet_info = {
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.0.0/24"
  name              = "Project1_publicsubnet"
}
igw_name = "Project1_igw"
rt_name  = "Project1_rt"
sg_name  = "Project1_SG"
instance_info = {
  instance_type = "t2.micro"
  name          = "Project1_EC2"
}
null = "8"