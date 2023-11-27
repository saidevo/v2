resource "aws_key_pair" "key" {
  key_name   = "Project1_key"
  public_key = file("~/.ssh/id_rsa.pub")
}
resource "aws_instance" "instance" {
  ami                         = "ami-02a2af70a66af6dfb"
  associate_public_ip_address = true
  instance_type               = var.instance_info.instance_type
  key_name                    = aws_key_pair.key.key_name
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  tags = {
    "Name" = var.instance_info.name
  }
  depends_on = [
    aws_key_pair.key,
    aws_vpc.vpc,
    aws_subnet.public_subnet,
    aws_security_group.sg
    ]
}
resource "null_resource" "null" {
  triggers = {
    instance = var.null
  }
  connection {
    host        = aws_instance.instance.public_ip
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    type        = "ssh"
  }
  provisioner "file" {
    source      = "project.sh"
    destination = "project.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x project.sh",
      "sh ./project.sh"
    ]
  }
  depends_on = [
    aws_instance.instance
  ]
}

