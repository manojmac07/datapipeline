#!/bin/bash
apt update -y
apt install -y python3-pip git
pip3 install apache-airflow==2.6.0 dbt-core==1.5.0 apache-airflow-providers-snowflake==3.3.0 dbt-snowflake==1.5.0
mkdir -p /home/ubuntu/{dags,dbt_project}
cd /home/ubuntu
git clone git@github.com:manojmac07/datapipeline.git project

ln -s project/dags dags
ln -s project/dbt_project dbt_project
