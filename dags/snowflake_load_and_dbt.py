from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from datetime import datetime

default_args = {'start_date': datetime(2024, 1, 1)}

with DAG(
    "load_and_transform_snowflake",
    default_args=default_args,
    schedule_interval="@hourly",
    catchup=False
) as dag:

    load_to_snowflake = SnowflakeOperator(
        task_id="copy_from_s3",
        snowflake_conn_id="my_snowflake_conn",  # configure this connection in Airflow UI
        sql="""
            COPY INTO raw_db.raw_stream_data
            FROM @my_s3_stage/stream/
            FILE_FORMAT = (TYPE = 'JSON')
            ON_ERROR = 'CONTINUE';
        """
    )

    run_dbt = BashOperator(
        task_id="run_dbt_transform",
        bash_command="cd /home/ubuntu/project/dbt_project && dbt run --profiles-dir ."
    )

    load_to_snowflake >> run_dbt
