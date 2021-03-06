resource "aws_db_instance" "rds" {
  #provider = aws.mumbai

  allocated_storage    = 30
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "11.1"
  instance_class       = "${var.db_instance_type}"
  name                 = "database1"
  username             = "aabhusan"
  password             = "leapfrog123"
  parameter_group_name = "default.postgres11"
  db_subnet_group_name = "${aws_db_subnet_group.rds-2.name}"
  max_allocated_storage = 100
  deletion_protection   = false
  vpc_security_group_ids=["${aws_security_group.rds-2.id}"]
}


resource "aws_security_group" "rds-2" {
    #provider = aws.mumbai
    name= "db2_rds_sg"
    vpc_id= "vpc-0e555cebd2854b4d3"
    
    lifecycle{
        create_before_destroy=true

    }

    ingress{
        from_port=5432
        to_port=5432
        protocol="tcp"
        cidr_blocks=["202.70.67.113/32","182.93.83.51/32","202.166.206.8/32","202.79.34.78/32"]

    }
    egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
        self= true
    }
    tags={
        name= "rds2-sg"
    }   
}

resource "aws_db_subnet_group" "rds-2" {

  #provider = aws.mumbai
  name       = "rds-2_subnet_group"
  subnet_ids = ["subnet-0d4598adf89c10a0f","subnet-0c57237db35480d2d"]
  tags = {
    Name = "My DB subnet group for rds-2"
  }
}