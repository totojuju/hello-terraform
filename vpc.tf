resource "aws_vpc" "hello_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "hello-vpc"
    }
}

resource "aws_subnet" "public" {
    count = 2
    vpc_id = aws_vpc.hello_vpc.id
    cidr_block = cidrsubnet(aws_vpc.hello_vpc.cidr_block, 8, count.index)
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "hello-public-${count.index}"
    }
}

resource "aws_subnet" "private" {
    count = 2
    vpc_id = aws_vpc.hello_vpc.id
    cidr_block = cidrsubnet(aws_vpc.hello_vpc.cidr_block, 8, count.index + 10)
    availability_zone = var.azs[count.index]

    tags = {
        Name = "hello-private-${count.index}"
    }
}