# gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/pdf-converter



gcloud functions deploy helloWorld   --stage-bucket mycloudfunction2021jan11   --trigger-topic hello_world   --runtime nodejs10

Deploying function (may take a while - up to 2 minutes)...done.
availableMemoryMb: 256
buildId: cc64fd08-9770-449c-8a62-22d2eabf61bb
entryPoint: helloWorld
eventTrigger:
  eventType: google.pubsub.topic.publish
  failurePolicy: {}
  resource: projects/qwiklabs-gcp-03-9fddf7549e8d/topics/hello_world
  service: pubsub.googleapis.com
ingressSettings: ALLOW_ALL
labels:
  deployment-tool: cli-gcloud
name: projects/qwiklabs-gcp-03-9fddf7549e8d/locations/us-central1/functions/helloWorld
runtime: nodejs10
serviceAccountEmail: qwiklabs-gcp-03-9fddf7549e8d@appspot.gserviceaccount.com
sourceArchiveUrl: gs://mycloudfunction2021jan11/us-central1-projects/qwiklabs-gcp-03-9fddf7549e8d/locations/us-central1/functions/helloWorld-txsgpocapxql.zip
status: ACTIVE
timeout: 60s
updateTime: '2021-01-11T19:19:10.130Z'
versionId: '2'



gcloud pubsub lite-topics create mytopic --zone=us-central1-a --partitions=1 --per-partition-bytes=30GiB --message-retention-period=2w