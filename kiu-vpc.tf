resource "aws_vpc" "kiu_vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true  # Habilita DNS en la VPC
  enable_dns_hostnames = true  # Permite resolución de nombres

  tags = {
    Name = "kiu-vpc"
  }
}

# Crear dos subnets públicas en diferentes AZs
resource "aws_subnet" "kiu_subnet_public" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.kiu_vpc.id
  cidr_block        = element(var.subnet_cidrs, count.index)
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true  # Hace que las instancias obtengan una IP pública

  tags = {
    Name = "kiu-subnet-public-${count.index}"
  }
}

# Crear Internet Gateway
resource "aws_internet_gateway" "kiu_igw" {
  vpc_id = aws_vpc.kiu_vpc.id

  tags = {
    Name = "kiu-internet-gateway"
  }
}

# Crear tabla de rutas pública para la VPC
resource "aws_route_table" "kiu_public_rt" {
  vpc_id = aws_vpc.kiu_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kiu_igw.id
  }

  tags = {
    Name = "kiu-public-route-table"
  }
}

# Asociar la tabla de rutas pública con las subnets públicas
resource "aws_route_table_association" "kiu_public_rt_assoc" {
  count          = length(aws_subnet.kiu_subnet_public[*].id)
  subnet_id      = element(aws_subnet.kiu_subnet_public[*].id, count.index)
  route_table_id = aws_route_table.kiu_public_rt.id
}
