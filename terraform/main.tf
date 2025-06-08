module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

module "kinesis" {
  source = "./modules/kinesis"
  stream_name = var.stream_name
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  key_name = module.iam.key_name
  user_data_script = file("./scripts/user_data.sh")
}

module "firehose" {
  source       = "./modules/firehose"
  firehose_name = var.firehose_name
  bucket_arn         = module.s3.bucket_arn
}
