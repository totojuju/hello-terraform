resource "aws_eip" "nat" {
    domain = "vpc"

    tags = {
        Name = "hello-nat-eip"
    }
}

resource "aws_nat_gateway" "hello" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public[0].id

    tags = {
        Name = "hello-nat-gateway"
    }

    depends_on = [aws_internet_gateway.hello]
}