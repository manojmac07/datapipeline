cd terraform
terraform init
terraform apply \
  -var="bucket_name=my-pipeline-bucket" \
  -var="stream_name=my-stream" \
  -var="firehose_name=my-firehose-stream" \
  -var="key_name=my-ec2-key"


terraform output -raw private_key_pem > ec2_key.pem
chmod 400 ec2_key.pem
ssh -i ec2_key.pem ec2-user@<EC2_PUBLIC_IP>


airflow db init                 # Initialize DB (if not done)
airflow scheduler &             # Start scheduler in background
airflow webserver -p 8080 &     # Start webserver on port 8080

