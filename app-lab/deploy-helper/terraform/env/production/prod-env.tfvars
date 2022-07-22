#Database variables
db_subnet_ids = [] #get from VPC Output
db_security_group_id = "" #get from VPC Output
db_instance_class = "db.t3.medium"
db_engine = "aurora-mysql"
db_engine_version = "8.0"
db_database_name = "testdb"
db_master_username = "admin"
db_master_password = "Tientuan1997"
db_backup_windows = "20:00-22:00"
db_number_of_reader_node = 0
db_skip_final_snapshot = true

#ALB variables
alb_vpc_id = "" #Input from VPC output
alb_subnet_ids = [] #Input from VPC output
alb_security_group_ids = [] #Input from VPC output
