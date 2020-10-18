data "aws_instance" "ec2_instance" {
  instance_id = "i-0cb88dc08e243d2c0"

  filter {
    name   = "image-id"
    values = ["ami-ec8bcd8f"]
  }

  filter {
    name   = "tag:Name"
    values = ["demo"]
  }
}
