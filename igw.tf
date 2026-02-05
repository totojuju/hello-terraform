resource "aws_internet_gateway" "hello" {
    vpc_id = aws_vpc.hello_vpc.id

    tags = {
        Name = "hello-igw"
    }
}