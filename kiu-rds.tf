resource "aws_db_instance" "db_kiu" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine              = "postgres"
  engine_version      = "17.3"
  instance_class      = var.db_instance_class
  identifier         = var.db_name
  username          = var.db_username
  password          = var.db_password
  publicly_accessible = false
  vpc_security_group_ids = ["sg-0217a9fb35cc351d1"]
}