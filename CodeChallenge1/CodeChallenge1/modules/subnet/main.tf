resource "aws_subnet" "subnet" {
  count = length(var.subnets)
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = element(concat(var.subnets, [""]), count.index)
  availability_zone       = element(concat(var.azs, [""]), count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-subnet-${count.index}-${var.env}"
  }
}