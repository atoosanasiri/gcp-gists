gcloud config set project cio-cpo-ai-lab-7d76df
cd source_repository/pace_ai_lab_restful_stat_canada

bq show --format=prettyjson $GOOGLE_CLOUD_PROJECT:GOOGLE_CLOUD_PROJECT

bq update \
--Lable "My new description" \
$GOOGLE_CLOUD_PROJECT:GOOGLE_CLOUD_PROJECT.test


cio-cpo-ai-lab-7d76dfm 
bq rm Restful_Statcan.avg_foreign_xchg_rates      
bq rm Restful_Statcan.core_inflation_cpi_common      
bq rm Restful_Statcan.core_inflation_cpi_median
bq rm Restful_Statcan.core_inflation_cpi_trim        
bq rm Restful_Statcan.cpi_canada_all_excl_gasoline   
bq rm Restful_Statcan.series_info                    
bq rm Restful_Statcan.cpi_canada_all_items

bq load \
--autodetect \
--source_format=NEWLINE_DELIMITED_JSON \
racing.race_results \
gs://just_a_bucket/race_results.json

pin a dataset 
Under Resources find the bigquery-public-data dataset (if it's not present already, use this link to pin the dataset)
https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=google_analytics_sample&t=ga_sessions_20170801&page=table

select
v.value,
v.refPer as record_date
from `cio-cpo-ai-lab-7d76df.Restful_Statcan.avg_foreign_xchg_rates` as r,
unnest (r.vectorDataPoint) as v
order by record_date desc
limit 10

select
count(v.value)
from `cio-cpo-ai-lab-7d76df.Restful_Statcan.core_inflation_cpi_common` as r,
unnest (r.vectorDataPoint) as v
limit 1000

select
count(productId)
from `cio-cpo-ai-lab-7d76df.Restful_Statcan.avg_foreign_xchg_rates`


