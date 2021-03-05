https://cloud.google.com/bigquery/docs/datasets#bq

Creating a dataset
bq mk command with --location command --default_table_expiration --default_partition_expiration

bq mk \
--dataset \
--default_table_expiration 3600 \
--description "This is my dataset." \
myfirstdataset


--BigQuery cookbook
--https://support.google.com/analytics/answer/4419694?hl=en
--Basic query examples
#Total transactions per device browser in July 2017
#standardSQL
SELECT
device.browser,
SUM ( totals.transactions ) AS total_transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
_TABLE_SUFFIX BETWEEN '20170701' AND '20170731'
GROUP BY
device.browser
ORDER BY
total_transactions DESC



bigquery-public-data:google_analytics_sample
bq mk --transfer_config --data_source="bigquery-public-data:google_analytics_sample" --target_dataset="gcloud-cert-2020:mysecondset"

--copying a table:
create or replace table `project.dataset.table2bcreatedName` as (
selct * from `dataset.table2bCopied` 
limit 1000)