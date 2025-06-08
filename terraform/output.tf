output "bucket_name" {
  value = module.s3.bucket_name
}

output "kinesis_stream_name" {
  value = module.kinesis.stream_name
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "private_key_pem" {
  value     = module.iam.private_key_pem
  sensitive = true
}
