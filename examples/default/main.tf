# Create a VPC
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
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
