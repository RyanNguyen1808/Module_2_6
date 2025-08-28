module "dynamoDB"{
  source = "./Modules/DB/DynamoDB"

  table_name = "ryan-bookinventory"
  partition_key = "ISBN"
  partition_key_data_type = "S"
  sort_key = "Genre"
  sort_key_data_type = "S"
}

module "iam"{
    source = "./Modules/IAM"
    dynamoDB_table_arn = module.dynamoDB.table_arn
}

module "ec2" {
  source         = "./Modules/EC2"
  instance_type  = "t3.micro"
  instance_count = 1
  vpc_id         = "vpc-0bdb0cb7149a39365"
  enable_public_subnet  = true
  key_name = "ec2 key pair"
  instance_profile_name = module.iam.ec2_instance_profile_name
}
