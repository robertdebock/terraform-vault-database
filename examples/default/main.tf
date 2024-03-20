# Create a VPC
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

# Create a subnet.
resource "aws_subnet" "default" {
  count      = 3
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.${count.index}.0/24"
}

# Add a security group.
resource "aws_security_group" "default" {
  name        = "allow_databases"
  description = "Allow database inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    owner = "robertdebock"
  }
}

# Create a db subnet group.
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = aws_subnet.default[*].id
}

# Create a database instance.
resource "aws_db_instance" "default" {
  allocated_storage      = 10
  identifier             = "test"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  db_name                = "test"
  username               = "foo"
  password               = "foobarbaz"
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.default.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
  tags = {
    owner = "robertdebock"
  }
}

module "vault_db" {
  source      = "../../"
  db_username = aws_db_instance.default.username
  db_password = aws_db_instance.default.password
  db_hostname = aws_db_instance.default.address
}
