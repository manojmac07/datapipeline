SELECT
  event_id,
  event_type,
  received_at
FROM {{ ref('raw_stream_data') }}
WHERE received_at >= dateadd(hour, -1, current_timestamp);
