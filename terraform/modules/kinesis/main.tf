resource "aws_kinesis_stream" "data_stream" {
  name        = var.stream_name
  shard_count = 1
}