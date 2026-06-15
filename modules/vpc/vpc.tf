# Create the main VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block # CIDR block for our VPC (e.g. 10.0.0.0/16)
  enable_dns_support   = true               # Enable DNS support in the VPC
  enable_dns_hostnames = true               # Enable DNS hostnames for resources in the VPC

  tags = {
    Name = "${var.vpc_name}-vpc" # Add a tag that includes the VPC name
  }
}

# Create the public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)          # Create several subnets, the count is the length of public_subnets
  vpc_id                  = aws_vpc.main.id                     # Attach each subnet to the VPC created above
  cidr_block              = var.public_subnets[count.index]     # CIDR block for this specific subnet from public_subnets
  availability_zone       = var.availability_zones[count.index] # Availability zone for each subnet
  map_public_ip_on_launch = true                                # Automatically assign public IPs to instances in the subnet

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}" # Tag with the subnet number
    # count.index is the "count" loop index, which starts at 0.
    # ${count.index + 1} adds +1 to get a human-friendly number (1, 2, 3 instead of 0, 1, 2).
  }
}

# Create the private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)         # Create several private subnets, the count is the length of private_subnets
  vpc_id            = aws_vpc.main.id                     # Attach each private subnet to the VPC
  cidr_block        = var.private_subnets[count.index]    # CIDR block for this specific subnet from private_subnets
  availability_zone = var.availability_zones[count.index] # Availability zone for the subnets

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}" # Tag for the subnet with a number
    # ${count.index + 1} is used so the subnet numbering starts at 1.
  }
}

# Create the Internet Gateway for the public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id # Attach the Internet Gateway to the VPC for internet access

  tags = {
    Name = "${var.vpc_name}-igw" # Tag to identify the Internet Gateway
  }
}
