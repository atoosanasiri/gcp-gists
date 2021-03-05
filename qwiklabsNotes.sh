nano thepolicy.json 

{
  "bindings": [
  {
     "members": [
       "serviceAccount:cloud-iot@system.gserviceaccount.com"
     ],
     "role": "roles/pubsub.publisher"
   }
 ],
 "etag": "BwW44t_cqwU=",
 "version": 1
}


gcloud pubsub topics create iotlab

gcloud pubsub topics  describe iotlab

gcloud pubsub topics set-iam-policy iotlab thepolicy.json

bq mk iotlabdataset
bq mk -t --expiration 3600 --description "This is my table"  iotlabdataset.sensordata timestamp:TIMESTAMP,device:STRING,temperature:FLOAT

gsutil mb gs://

gcloud dataflow jobs run iotlabflow --gcs-location=gs://qwiklabs-gcp-03-9e6cd36df441-bucket/tmp/ --region=us-central1 --max-workers=2

export PROJECT_ID=qwiklabs-gcp-03-9e6cd36df441

export MY_REGION=us-central1



ETL Processing on Google Cloud Using Dataflow and BigQuery

gsutil -m cp -R gs://spls/gsp290/dataflow-python-examples .
export PROJECT=<YOUR-PROJECT-ID>
gcloud config set project $PROJECT
gsutil mb -c regional -l us-central1 gs://$PROJECT
gsutil cp gs://spls/gsp290/data_files/usa_names.csv gs://$PROJECT/data_files/
gsutil cp gs://spls/gsp290/data_files/head_usa_names.csv gs://$PROJECT/data_files/

bq mk lake

cd dataflow-python-examples/
# Here we set up the python environment.
# Pip is a tool, similar to maven in the java world
sudo pip install virtualenv

#Dataflow requires python 3.7
virtualenv -p python3 venv

source venv/bin/activate
pip install apache-beam[gcp]==2.24.0

Data Ingestion - Apache Beam Pipeline
python dataflow_python_examples/data_ingestion.py --project=$PROJECT \
--region=us-central1 --runner=DataflowRunner --staging_location=gs://$PROJECT/test \
--temp_location gs://$PROJECT/test \
--input gs://$PROJECT/data_files/head_usa_names.csv --save_main_session

Data Transformation - Apache Beam Pipeline
python dataflow_python_examples/data_transformation.py --project=$PROJECT \
--region=us-central1 --runner=DataflowRunner --staging_location=gs://$PROJECT/test \
--temp_location gs://$PROJECT/test /
--input gs://$PROJECT/data_files/head_usa_names.csv --save_main_session

Data Enrichment - Apache Beam Pipeline
python dataflow_python_examples/data_enrichment.py --project=$PROJECT \
--region=us-central1 --runner=DataflowRunner --staging_location=gs://$PROJECT/test \
--temp_location gs://$PROJECT/test --input gs://$PROJECT/data_files/head_usa_names.csv --save_main_session

Data lake to Mart - Apache Beam Pipeline
python dataflow_python_examples/data_lake_to_mart.py \
--worker_disk_type="compute.googleapis.com/projects//zones//diskTypes/pd-ssd" \
--max_num_workers=4 --project=$PROJECT --runner=DataflowRunner --staging_location=gs://$PROJECT/test \
--temp_location gs://$PROJECT/test --save_main_session --region=us-central1

gcloud compute instances create bigquery-instance --region=us-central1 --zone=us-central1-a --machine-type=n1-standard-1 --boot-disk="Debian GNU/Linux 9" --service-account=bigquery-qwiklab

###get the param out of a command
#TOKEN=$(curl http://127.0.0.1:10080/login -u user|jq -r '.token')
