resource "aws_route_table" "public" {
  vpc_id = "${var.vpc_id}"
  tags = {
    Name = "${var.project}-rt-${var.env}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
  tags = {
    Name = "${var.project}-igw-${var.env}"
  }
}

resource "aws_route" "public_igw_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.subnet_ids)
  subnet_id      = element(var.subnet_ids, count.index)
  route_table_id = aws_route_table.public.id
}
