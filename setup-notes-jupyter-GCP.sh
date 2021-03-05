--> This is the proxy for package installation
pip install "package_name" --proxy=198.161.14.25:8080

gcloud config list

--> proxy for Google: 198.161.14.26:1328
gcloud config set proxy/type http
gcloud config set proxy/address 198.161.14.26
gcloud config set proxy/port 1328

gcloud config set project "cio-datahub-ws-cpoai-pr-4705a7"

--> you cannot do below command
gcloud config set --zone "northamerica-northeast1-a"

gcloud compute instances list

gcloud config set project 

gsutil ls gs://cio-datahub-ws-cpoai-pr-4705a7-cpows

gcloud compute ssh --zone "northamerica-northeast1-a" "dsnotebook-large-c4473f39" --tunnel-through-iap -- -L 8080:localhost:8080

http://localhost:8080


gcloud auth application-default login

gcsfuse cio-datahub-ws-cpoai-pr-4705a7-cpows /home/jupyter/content/folders/

#just to make sure you have all you need to work, you can unzip a specific zip file to a temp folder or local with this two commands:

tar xvzf anaj/acm_files/acm/unstructured_data_batch1.tar.gz -C anaj/acm_files/

cd /home/jupyter/content/folders/anaj/acm_files/
mkdir temp
unzip /home/jupyter/content/folders/anaj/acm_files/CW2050367_CW2050367_Doc2513897795_Attachments.zip -d temp/
--> for the .tar.zip always use tar xvzf  and for .zip files always use unzip

#working wirh git for vm creation
user: shuchi181
password: Telus@github1

Shuchita Singh, Nov 20, 1:16 PM
you should be pushing a tag
when you push the matching tag, the build will run
this is what John has done too
git tag cio-datahub-ws-cpoai-pr.plan_v0.0.29
git push --tags

Shuchita Singh, Nov 20, 1:16 PM, Edited
https://git-scm.com/book/en/v2/Git-Basics-Tagging#:~:text=Sharing%20Tags&text=You%20will%20have%20to%20explicitly,git%20push%20origin%20.&text=If%20you%20have%20a%20lot,to%20the%20git%20push%20command.

Shuchita Singh, Nov 20, 1:18 PM
https://github.com/telus/tf-infra-cio-cpo-ai-lab/blob/np/terraform/main.tf
John: https://github.com/telus/tf-infra-cio-datahub-wrksp-builder
$ git

config --global http.proxy http://198.161.14.26:1328
git pull
git config --list

git add .
git push
git ls-remote --heads
git remote -v
git pull origin master


John Huang11:36 AM
git tag -a cio-datahub-ws-cpoai-pr.planv0.0.42 -m "tag version cio-datahub-ws-cpoai-pr.planv0.0.42"
git push origin cio-datahub-ws-cpoai-pr.planv0.0.42

git tag -a cio-datahub-ws-cpoai-pr.v0.0.42 -m "tag version cio-datahub-ws-cpoai-pr.v0.0.42"
git push origin cio-datahub-ws-cpoai-pr.v0.0.42
