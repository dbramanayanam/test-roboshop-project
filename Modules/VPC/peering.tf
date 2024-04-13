resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_required ? 1 : 0
  vpc_id        = aws_vpc.vpc.id
  peer_vpc_id   = var.provide_vpc_id == "" ? data.aws_vpc.default_vpc.id : var.provide_vpc_id 
  auto_accept = var.provide_vpc_id == "" ? true : false
  tags = merge(
        var.common_tags,
        var.vpc_peering_tags,
        {
            Name = "${local.name}"
        }
    ) 

  }
resource "aws_route" "acceptor_route" {
  count = var.is_peering_required && var.provide_vpc_id== "" ? 1 : 0
  route_table_id            = data.aws_route_table.default.id
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

resource "aws_route" "public_peering" {
  count = var.is_peering_required && var.provide_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

resource "aws_route" "private_peering" {
  count = var.is_peering_required && var.provide_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

resource "aws_route" "database_peering" {
  count = var.is_peering_required && var.provide_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.database_rt.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}