resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames   = var.enable_dns_hostnames
  tags = merge( 
    var.common_tags, 
    var.vpc_tags,
    {
      Name = local.name
         
    }
  
  )
}

resource "aws_internet_gateway" "gw" {
vpc_id = aws_vpc.vpc.id
tags = merge(
       var.common_tags,
       var.igw_tags,
        {
            Name = local.name
         
        }
    )
}


resource "aws_subnet" "public" {
  count      = length(var.public_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_cidr[count.index]
  availability_zone = local.value[count.index]

  tags = merge(
       var.common_tags,
       var.subnet_tags,
        {
            Name = "${local.name}-public-${local.value[count.index]}"
         
        }
    )
}

resource "aws_subnet" "private" {
  count      = length(var.private_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_cidr[count.index]
  availability_zone = local.value[count.index]

  tags = merge(
       var.common_tags,
       var.subnet_tags,
        {
            Name = "${local.name}-private-${local.value[count.index]}"
         
        }
    )
}

resource "aws_subnet" "database" {
  count      = length(var.database_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.database_cidr[count.index]
  availability_zone = local.value[count.index]

  tags = merge(
       var.common_tags,
       var.subnet_tags,
        {
            Name = "${local.name}-database-${local.value[count.index]}"
         
        }
    )
}

resource "aws_eip" "eip" {
  domain           = "vpc"
}


resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id

  tags =  merge(
     var.common_tags,
     var.natgw_tags,
       {
          Name = "${local.name}-natgw"
       }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
      var.common_tags,
      var.public_rt_tags,

   {
      Name = "${local.name}-public_route_table"
      
   }
  ) 
  
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
      var.common_tags,
      var.private_rt_tags,

   {
      Name = "${local.name}-private_route_table"
      
   }
  ) 
  
}

resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
      var.common_tags,
      var.database_rt_tags,

   {
      Name = "${local.name}-database_route_table"
      
   }
  ) 
  
}

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id  = aws_internet_gateway.gw.id
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id  = aws_nat_gateway.natgw.id
}

resource "aws_route" "private_db" {
  route_table_id            = aws_route_table.database_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id  = aws_nat_gateway.natgw.id
}

resource "aws_route_table_association" "public_rt_association" {
  count      = length(var.public_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "private_rt_association" {
  count      = length(var.private_cidr)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}


resource "aws_route_table_association" "database_rt_association" {
  count      = length(var.database_cidr)
  subnet_id      = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database_rt.id
}