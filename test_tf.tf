# Hardcoded credentials
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

provider "aws" {
  alias      = "backup"
  region     = "eu-west-1"
  access_key = "AKIAI44QH8DHBEXAMPLE"
  secret_key = "je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY"
}

# Overly permissive security group - open to the world
resource "aws_security_group" "allow_all" {
  name = "allow_all"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Hardcoded passwords, no encryption, public access, magic numbers
resource "aws_db_instance" "production" {
  identifier              = "prod-db"
  engine                  = "mysql"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = "admin"
  password                = "SuperSecret123!"
  publicly_accessible     = true
  skip_final_snapshot     = true
  storage_encrypted       = false
  backup_retention_period = 0
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.allow_all.id]
}

# Duplicate resource (copy-pasted with minor changes)
resource "aws_db_instance" "production_backup" {
  identifier              = "prod-db-backup"
  engine                  = "mysql"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = "admin"
  password                = "BackupPass456!"
  publicly_accessible     = true
  skip_final_snapshot     = true
  storage_encrypted       = false
  backup_retention_period = 0
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.allow_all.id]
}

# S3 bucket with no versioning, no encryption, public ACL
resource "aws_s3_bucket" "data" {
  bucket = "my-company-prod-data"
  acl    = "public-read-write"
  tags   = {}
}

# IAM user with inline policy, hardcoded credentials in user_data
resource "aws_iam_user" "deploy" {
  name = "deploy-user"
}

resource "aws_iam_user_policy" "admin_access" {
  name = "admin-access"
  user = aws_iam_user.deploy.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
    }]
  })
}

# EC2 with hardcoded secrets in user_data, no encryption, public IP
resource "aws_instance" "app" {
  ami                         = "ami-12345678"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_all.id]
  user_data                   = <<-EOF
    #!/bin/bash
    export DB_PASSWORD="SuperSecret123!"
    export API_KEY="AKIAIOSFODNN7EXAMPLE"
    export MONGO_URI="mongodb://root:rootpass@prod-mongo:27017/maindb"
    export JWT_SECRET="my-super-secret-jwt-key-do-not-share"
    export SLACK_TOKEN="xoxb-123456789012-1234567890123-ABCDEFghijklMNOPqrst"
    echo "PRIVATE_KEY=-----BEGIN RSA PRIVATE KEY-----" >> /etc/env
    curl http://admin:pass123@internal-api:8080/setup
    mysql -u root -prootpass123 -h prod-db -e "GRANT ALL ON *.* TO 'admin'@'%'"
  EOF
  root_block_device {
    encrypted = false
  }
}

# Hardcoded output of sensitive values
output "db_password" {
  value = "SuperSecret123!"
}
output "api_secret" {
  value = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}
