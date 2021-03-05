#!/bin/bash
echo "Clone the repo from the github"
#rm -rf data-science-on-gcp/
#git clone https://github.com/GoogleCloudPlatform/data-science-on-gcp/
echo

#echo "Change to the source code directory for this lab in the Cloud Shell"
cd ~/data-science-on-gcp/02_ingest/
echo 

echo "Create environment variables that will be used later"
PROJECT=$(gcloud info --format='value(config.project)')
REGION=us-central1
BUCKET=${PROJECT}-ml
echo

echo "Create the data storage bucket for the lab"
#gsutil rm gs://$BUCKET
#gsutil mb gs://$BUCKET
echo

#echo "Change to the monthly update directory"
cd monthlyupdate/

echo "#Create an isolated Python 3 environment called env with virtualenv"
virtualenv -p python3 env
echo

echo "#Activate virtualenv"
source env/bin/activate
echo

echo "#Make sure the required Python modules are installed"
#pip install -r requirements.txt
echo

echo "#Try to download data with a valid year"
#python ~/data-science-on-gcp/02_ingest/monthlyupdate/ingest_flights.py  --bucket $BUCKET --year 2015 --month 01
echo


function create_cloud_function {
    #The URLs used to trigger Cloud Functions are wide open, 
    #includes a security check using a hard coded security token in the function
    #that must be provided when the URL is called
    echo "#Generate a new token using openSSL"
    TOKEN=$(openssl rand -base64 48 | tr -d /=+ | cut -c -32)
    sed -i "s/DI8TWPzTedNF0b3B8meFPxXSWw6m3bKG/$TOKEN/" ~/data-science-on-gcp/02_ingest/monthlyupdate/main.py

    echo "#limit the exposure of your function to denial-of-service attacks by using a complex name to obscure the URL"
    FUNCTION_NAME=ingest_flights_$(openssl rand -base64 48 | tr -d /=+ | cut -c -32)
    echo $FUNCTION_NAME 
    
    echo "#deploy the Cloud Function using this name"

    gcloud alpha functions deploy $FUNCTION_NAME\
	 --entry-point=ingest_flights \
	 --runtime python37 \
	 --trigger-http \
	 --timeout 480s \
	 --allow-unauthenticated
    echo
    }

#Create the full URL that you can use to trigger the Cloud Function
#by combining the region, project-id and the Cloud Function name
URL="https://${REGION}-${PROJECT}.cloudfunctions.net/${FUNCTION_NAME}"

#Create the JSON parameters for the Cloud Function 
echo {\"year\":\"2015\"\,\"month\":\"03\"\,\"bucket\":\"${BUCKET}\", \"token\":\"${TOKEN}\"} > /tmp/message
cat /tmp/message

#Call the Cloud Function by using Curl to pass the json parameters to your Cloud function trigger URL 
#using a HTTP POST request.
curl -X POST $URL -H "Content-Type:application/json" --data-binary @/tmp/message

#confirm that the command has succeeded by listing the files in the Cloud Storage bucket
#gsutil list gs://$BUCKET/flights/raw

#PART TWO
#Schedule a task using Google Cloud Scheduler
#In order to use Cloud Scheduler you must enable App engine in the appropriate region.
#gcloud app create --region us-central

#Create the JSON parameters for the storage bucket and authentication token
echo {\"bucket\":\"${BUCKET}\", \"token\":\"${TOKEN}\"} > /tmp/message

#Create the cron-topic Cloud Pub/Sub topic and the cron-sub subscription
TOPIC_STAUTS=$(gcloud pubsub topics list --filter=name:cron-topic)
if [ -z "$TOPIC_STAUTSS"]
then
    gcloud pubsub topics create cron-topic
    gcloud pubsub subscriptions create cron-sub --topic cron-topic
else
    echo "topic ${TOPIC_STAUTS} already exists"
fi

#Create the Cloud Scheduler task:
cloud beta scheduler jobs create http monthlyupdate \
	--schedule="* 10 8 * *" \
	--uri=$URL \
	--max-backoff=7d --max-retry-attempts=5 \
	--max-retry-duration=3h \
	--min-backoff=1h \
	--time-zone="US/Eastern" \
    --message-body-from-file=/tmp/message \
    --headers Content-Type=application/json
#In the Google Cloud Platform console navigation pane navigate to Tools > Cloud Scheduler.
#For the monthlyupdate job click Run now link on the far right of the screen. The task will take about a minute complete.
#Click Refresh to check the status.
#Once the Result status message has changed to "Success", open Cloud Storage by navigating to Storage > Browser